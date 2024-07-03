# typed: strict

require 'money'

require_relative './entities/rule'
require_relative './entities/item'
require_relative './rules/manager'

Money.locale_backend = nil

module Cashier
  # The Checkout class represents a shopping cart that scans,
  # removes, and calculates the total price of items based on given rules.
  class Checkout
    extend T::Sig

    sig { params(rules: T::Array[Cashier::Entities::Rule]).void }
    def initialize(rules)
      @rules = rules
      @items = T.let([], T::Array[Cashier::Entities::Item])
    end

    sig { returns(T::Array[Cashier::Entities::Rule]) }
    attr_reader :rules

    sig { returns(T::Array[Cashier::Entities::Item]) }
    attr_reader :items

    sig { params(item: Cashier::Entities::Item).void }
    def scan(item)
      items << item
    end

    sig { params(code: String).void }
    def remove(code)
      index = @items.find_index { |item| item.code == code }
      index ? @items.delete_at(index) : nil
    end

    sig { returns(String) }
    def total
      cents = Cashier::Rules::Manager.new.evaluate(items:, rules:)
      Money.from_cents(cents, 'GBP').format
    end
  end
end
