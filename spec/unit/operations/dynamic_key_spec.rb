# frozen_string_literal: true

RSpec.describe Dry::Logic::Operations::DynamicKey do
  subject(:operation) { described_class.new(predicate, name: :user) }

  include_context "predicates"

  let(:predicate) do
    Dry::Logic::Rule::Predicate.build(dynamic_key?).curry(:age)
  end

  describe "#call" do
    context "with a plain predicate" do
      it "returns a success for valid input" do
        expect(operation.(user: {'0': {age: 18}})).to be_success
      end

      it "returns a success for valid input with multiple dynamic keys" do
        expect(operation.(user: {'0': {age: 18}, '1': {age: 20}})).to be_success
      end

      it "returns a failure for invalid input" do
        result = operation.(user: { '1': { name: 'test' }})

        expect(result).to be_failure

        expect(result.to_ast).to eql(
          [:failure, [:user, [:dynamic_key,
                              [:user, [:predicate, [:dynamic_key?, [:key, [:name, :age], [:input, {'1': {name: 'test'}}]]]]]]]]
        )
      end
    end
  end
end
