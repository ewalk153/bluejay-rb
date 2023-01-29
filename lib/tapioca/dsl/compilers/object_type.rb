# typed: strict
# frozen_string_literal: true

require_relative "../../../rbi_ext/model"

module Tapioca
  module Compilers
    class ObjectType < Tapioca::Dsl::Compiler
      extend T::Sig

      ConstantType = type_member { { fixed: T.class_of(Bluejay::ObjectType) } }

      sig { override.returns(T::Enumerable[Module]) }
      def self.gather_constants
        all_classes.select { |c| c < Bluejay::ObjectType }
      end

      sig { override.void }
      def decorate
        root.create_path(constant.const_get(:Interface)) do |klass|
          klass.custom_create_method("resolve_typename", return_type: "String", is_final: true)

          klass.mark_abstract

          constant.interface_implementations.each do |interface_implementation|
            interface = interface_implementation.interface.const_get(:Interface)
            klass.create_include(interface.name)
          end

          constant.field_definitions.each do |field_definition|
            parameters = field_definition.argument_definitions.map do |argument_definition|
              create_param(argument_definition.name, type: argument_definition.type.sorbet_type)
            end

            return_type = field_definition.type.sorbet_type

            klass.custom_create_method(field_definition.resolver_method_name, parameters:, return_type:, is_abstract: true)
          end
        end
      end
    end
  end
end
