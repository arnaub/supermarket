# typed: strict

require_relative '../entities/rule'
require_relative '../entities/item'
require_relative './rule'
require_relative './buy_one_get_one_free'
require_relative './discount'
require_relative './two_thirds'

module Cashier
  module Rules
    # The Manager class oversees the application of various pricing rules to a
    # collection of items to compute the total cost adjustments.
    class Manager
      extend T::Sig

      sig { void }
      def initialize
        @rules = T.let(entities, T::Array[Cashier::Entities::Rule])
      end

      sig { returns(T::Array[Cashier::Entities::Rule]) }
      attr_reader :rules

      sig { returns(T::Array[Cashier::Entities::Rule]) }
      def list
        entities
      end

      sig { params(items: T::Array[Cashier::Entities::Item]).returns(Integer) }
      def evaluate(items)
        rules.map do |rule|
          rule.evaluate.call(items.filter { |item| item.code == rule.code })
        end.sum
      end

      private

      sig { returns(T::Array[T.class_of(Cashier::Rules::Rule)]) }
      def available_rules
        [
          Cashier::Rules::BuyOneGetOneFree,
          Cashier::Rules::Discount,
          Cashier::Rules::TwoThirds
        ]
      end

      sig { returns(T::Array[Cashier::Entities::Rule]) }
      def entities
        available_rules.map do |rule|
          Cashier::Entities::Rule.new(
            identifier: rule.identifier,
            code: rule.code,
            evaluate: lambda do |items|
              rule.evaluate(T.let(items, T::Array[Cashier::Entities::Item]))
            end
          )
        end
      end
    end
  end
end
