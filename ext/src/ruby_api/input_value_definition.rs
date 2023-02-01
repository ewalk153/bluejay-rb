use super::{
    coerce_input::CoerceInput,
    coercion_error::CoercionError,
    input_type_reference::InputTypeReference,
    json_value::{JsonValue, JsonValueInner},
    root,
};
use crate::helpers::WrappedStruct;
use convert_case::{Case, Casing};
use magnus::{
    function, method, scan_args::get_kwargs, DataTypeFunctions, Error, Module, Object, RHash,
    TypedData, Value,
};

#[derive(Debug, TypedData)]
#[magnus(class = "Bluejay::InputValueDefinition", mark)]
pub struct InputValueDefinition {
    name: String,
    description: Option<String>,
    r#type: WrappedStruct<InputTypeReference>,
    default_value: Option<JsonValue>,
    ruby_name: String,
}

impl InputValueDefinition {
    pub fn new(kw: RHash) -> Result<Self, Error> {
        let args = get_kwargs(kw, &["name", "type"], &["description", "default_value"])?;
        let (name, r#type): (String, WrappedStruct<InputTypeReference>) = args.required;
        let (description, default_value): (Option<Option<String>>, Option<JsonValue>) =
            args.optional;
        let description = description.unwrap_or_default();
        let _: () = args.splat;
        let ruby_name = name.to_case(Case::Snake);
        Ok(Self {
            name,
            description,
            r#type,
            default_value,
            ruby_name,
        })
    }

    pub fn name(&self) -> &str {
        self.name.as_str()
    }

    pub fn description(&self) -> Option<&str> {
        self.description.as_ref().map(String::as_str)
    }

    pub fn r#type(&self) -> &InputTypeReference {
        self.r#type.get()
    }

    pub fn default_value(&self) -> Option<Value> {
        self.default_value.as_ref().map(|v| v.to_owned().into())
    }

    pub fn is_required(&self) -> bool {
        if self.default_value.is_some() {
            false
        } else {
            self.r#type.get().is_required()
        }
    }

    fn ruby_name(&self) -> &str {
        self.ruby_name.as_str()
    }
}

impl DataTypeFunctions for InputValueDefinition {
    fn mark(&self) {
        self.r#type.mark();
    }
}

impl CoerceInput for InputValueDefinition {
    fn coerce_input(
        &self,
        value: Value,
        path: &[String],
    ) -> Result<Result<Value, Vec<CoercionError>>, Error> {
        self.r#type.get().coerce_input(value, path)
    }
}

impl bluejay_core::definition::InputValueDefinition for InputValueDefinition {
    type InputTypeReference = InputTypeReference;
    type Value = JsonValueInner;

    fn name(&self) -> &str {
        self.name.as_str()
    }

    fn description(&self) -> Option<&str> {
        self.description.as_ref().map(String::as_str)
    }

    fn r#type(&self) -> &Self::InputTypeReference {
        self.r#type.get()
    }

    fn default_value(&self) -> Option<&Self::Value> {
        self.default_value.as_ref().map(AsRef::as_ref)
    }
}

pub fn init() -> Result<(), Error> {
    let class = root().define_class("InputValueDefinition", Default::default())?;

    class.define_singleton_method("new", function!(InputValueDefinition::new, 1))?;
    class.define_method("name", method!(InputValueDefinition::name, 0))?;
    class.define_method("type", method!(|ivd: &InputValueDefinition| ivd.r#type, 0))?;
    class.define_method("ruby_name", method!(InputValueDefinition::ruby_name, 0))?;

    Ok(())
}
