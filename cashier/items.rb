module Cashier
  # The Items class represents a collection of items available in the cashier system.
  class Items
    ITEMS = [
      { code: 'GR1', name: 'Green tea', price: { cents: 3_11, currency: 'GBP' } },
      { code: 'SR1', name: 'Strawberries', price: { cents: 5_00, currency: 'GBP' } },
      { code: 'CF1', name: 'Coffee', price: { cents: 11_23, currency: 'GBP' } }
    ].freeze

    def self.items
      ITEMS
    end

    def self.find(code)
      ITEMS.find { |item| item[:code] == code }
    end
  end
end
