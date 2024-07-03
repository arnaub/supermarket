# typed: strict

module Cashier
  # The Items class represents a collection of items available in the cashier system.
  class Items
    extend T::Sig

    sig { returns(T::Array[Cashier::Entities::Item]) }
    def self.items
      entities
    end

    sig { params(code: String).returns(T.nilable(Cashier::Entities::Item)) }
    def self.find(code)
      entities.find { |item| item.code == code }
    end

    # rubocop:disable Metrics/MethodLength
    sig { returns(T::Array[Cashier::Entities::Item]) }
    def self.entities
      [
        Cashier::Entities::Item.new(
          code: 'GR1',
          name: 'Green tea',
          price: Cashier::Entities::Price.new(cents: 3_11, currency: 'GBP')
        ),
        Cashier::Entities::Item.new(
          code: 'SR1',
          name: 'Strawberries',
          price: Cashier::Entities::Price.new(cents: 5_00, currency: 'GBP')
        ),
        Cashier::Entities::Item.new(
          code: 'CF1',
          name: 'Coffee',
          price: Cashier::Entities::Price.new(cents: 11_23, currency: 'GBP')
        )
      ]
    end
    # rubocop:enable Metrics/MethodLength
  end
end
