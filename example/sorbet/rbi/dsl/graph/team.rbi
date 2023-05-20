# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for dynamic methods in `Graph::Team`.
# Please instead update this file by running `bin/tapioca dsl Graph::Team`.

module Graph::Team::Interface
  abstract!

  sig { abstract.returns(String) }
  def location; end

  sig { abstract.returns(String) }
  def name; end

  sig { abstract.returns(T::Array[Graph::Player::Interface]) }
  def players; end

  sig(:final) { returns(String) }
  def resolve_typename; end
end
