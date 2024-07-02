# typed: strict

require_relative './rule'

module Cashier
  module Rules
    # The TwoThirds class represents a rule that calculates the
    # total cost for items with a 1/3 discount.
    class TwoThirds < Cashier::Rules::Rule
      sig { override.returns(String) }
      def self.code
        'GR1'
      end

      sig { override.params(items: T::Array[Entities::Item]).returns(Integer) }
      def self.evaluate(items)
        count = items.count
        return 0 unless count.positive?

        price = T.must(items.first).price.cents

        count < 3 ? count * price : count * price * 2 / 3
      end
    end
  end
end
