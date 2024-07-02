module Cashier
  module Rules
    # The TwoThirds class represents a rule that calculates the 
    # total cost for items with a 1/3 discount.
    class TwoThirds
      def self.evaluate(items)
        count = items.count
        return 0 unless count.positive? 

        price = items.first[:price][:cents]
        
        count < 3 ? count * price : count * price * 2 / 3
      end
    end
  end
end
