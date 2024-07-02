module Cashier
  # The Checkout class represents a shopping cart that scans,
  # removes, and calculates the total price of items based on given rules.
  class Checkout
    def initialize(rules)
      @rules = rules
      @items = []
    end

    attr_reader :rules, :items

    def scan(item)
      items << item
    end

    def remove(code)
      index = @items.find_index { |item| item[:code] == code }
      index ? @items.delete_at(index) : nil
    end

    def total
      items.map { |item| item[:price][:cents] }.sum
    end
  end
end
