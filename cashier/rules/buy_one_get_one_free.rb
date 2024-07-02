# typed: strict

require_relative './rule'

module Cashier
  module Rules
    # The BuyOneGetOneFree class represents a rule that calculates the total
    # cost for items with a buy-one-get-one-free promotion.
    class BuyOneGetOneFree < Cashier::Rules::Rule
      sig { override.returns(String) }
      def self.code
        'GR1'
      end

      sig { override.params(items: T::Array[Entities::Item]).returns(Integer) }
      def self.evaluate(items)
        count = items.count
        return 0 unless count.positive?

        amount = T.must(items.first&.price&.cents)
        quotient = count / 2
        remainder = count % 2

        amount * (quotient + remainder)
      end
    end
  end
end
