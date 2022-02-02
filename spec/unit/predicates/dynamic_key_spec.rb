# frozen_string_literal: true

require "dry/logic/predicates"

RSpec.describe Dry::Logic::Predicates do
  describe "#dynamic_key?" do
    let(:predicate_name) { :dynamic_key? }

    context "when dynamic key is present in value" do
      let(:arguments_list) do
        [
          [:name, {'0': {name: "John"}}],
          [:age, {'1': {age: 18}}]
        ]
      end

      it_behaves_like "a passing predicate"
    end

    context "with key is not present in value" do
      let(:arguments_list) do
        [
          [:name, {'0': {age: 18}}],
          [:age, {'1': {name: "Jill"}}]
        ]
      end

      it_behaves_like "a failing predicate"
    end
  end
end
