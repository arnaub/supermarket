module Cashier
  module Rules
    # The BuyOneGetOneFree class represents a rule that calculates the total
    # cost for items with a buy-one-get-one-free promotion.
    class BuyOneGetOneFree
      def self.evaluate(items)
        count = items.count
        return 0 unless count.positive?

        amount = items.first[:price][:cents]
        quotient = count / 2
        remainder = count % 2

        amount * (quotient + remainder)
      end
    end
  end
end
