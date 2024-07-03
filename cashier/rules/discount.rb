# typed: strict

require_relative './rule'

module Cashier
  module Rules
    # The Discount class represents a rule that calculates the total
    # cost for items with a 50 cents discount
    class Discount < Cashier::Rules::Rule
      sig { override.returns(String) }
      def self.identifier
        'discount'
      end

      sig { override.returns(String) }
      def self.code
        'SR1'
      end

      sig { override.params(items: T::Array[Entities::Item]).returns(Integer) }
      def self.evaluate(items)
        count = items.count
        return 0 unless count.positive?

        amount = count < 3 ? T.must(items.first).price.cents : 4_50

        count * amount
      end
    end
  end
end
