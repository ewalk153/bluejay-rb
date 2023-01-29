# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for dynamic methods in `Graph::Schema`.
# Please instead update this file by running `bin/tapioca dsl Graph::Schema`.

class Graph::Schema
  class << self
    sig do
      params(
        query: String,
        operation_name: T.nilable(String),
        initial_value: Graph::Schema::Root,
        variables: T::Hash[String, T.untyped]
      ).returns(Bluejay::ExecutionResult)
    end
    def execute(query:, operation_name:, initial_value:, variables: {}); end
  end
end

module Graph::Schema::Root
  interface!

  sig { abstract.returns(Graph::QueryRoot::Interface) }
  def query; end
end
