module Cashier
  module Rules
    # The Discount class represents a rule that calculates the total
    # cost for items with a 50 cents discount
    class Discount
      def self.evaluate(items)
        count = items.count
        return 0 unless count.positive?

        amount = count < 3 ? items.first[:price][:cents] : 4_50

        count * amount
      end
    end
  end
end
