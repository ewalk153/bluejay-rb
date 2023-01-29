# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for dynamic methods in `Graph::QueryRoot`.
# Please instead update this file by running `bin/tapioca dsl Graph::QueryRoot`.

module Graph::QueryRoot::Interface
  abstract!

  sig { abstract.returns(T::Array[Graph::Person::Interface]) }
  def resolve_people; end

  sig { abstract.params(location: T.nilable(String)).returns(T::Array[Graph::Team::Interface]) }
  def resolve_teams(location); end

  sig(:final) { returns(String) }
  def resolve_typename; end
end
