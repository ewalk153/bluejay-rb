# typed: strict
# frozen_string_literal: true

module Bluejay
  class InterfaceType
    extend(Finalize)

    class << self
      extend(T::Sig)
      extend(T::Helpers)
      include(OutputTypeReferenceShorthands)
      include(InputTypeReferenceShorthands)
      include(NameFromClass)

      abstract!

      sig { overridable.returns(String) }
      def graphql_name
        name_from_class
      end

      sig { overridable.returns(T.nilable(String)) }
      def description
        nil
      end

      sig { abstract.returns(T::Array[FieldDefinition]) }
      def field_definitions; end

      sig { overridable.returns(T::Array[InterfaceImplementation]) }
      def interface_implementations
        []
      end

      protected

      sig(:final) { override.void }
      def finalize
        definition
      end

      private

      sig { returns(InterfaceTypeDefinition) }
      def definition
        @definition ||= T.let(nil, T.nilable(InterfaceTypeDefinition))
        @definition ||= begin
          interface_implementations = self.interface_implementations
          interface = Module.new do |mod|
            interface_implementations.each do |interface_implementation|
              mod.include(interface_implementation.interface.const_get(:Interface))
            end
          end
          const_set(:Interface, interface)
          InterfaceTypeDefinition.new(name: graphql_name, description:, field_definitions:, interface_implementations:)
        end
      end
    end
  end
end
