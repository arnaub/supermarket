# typed: strict

module Cashier
  # The Checkout class represents a shopping cart that scans,
  # removes, and calculates the total price of items based on given rules.
  class Checkout
    extend T::Sig


    sig { params(rules: T::Array[Entities::Rule]).void }
    def initialize(rules)
      @rules = rules
      @items = T.let([], T::Array[Entities::Item])
    end


    sig { returns(T::Array[Entities::Rule]) }
    attr_reader :rules

    sig { returns(T::Array[Entities::Item]) }
    attr_reader :items

    sig { params(item: Entities::Item).void }
    def scan(item)
      items << item
    end

    sig { params(code: String).void }
    def remove(code)
      index = @items.find_index { |item| item.code == code }
      index ? @items.delete_at(index) : nil
    end

    sig { returns(Integer) }
    def total
      items.map{|item| item.price.cents}.sum
    end
  end
end
