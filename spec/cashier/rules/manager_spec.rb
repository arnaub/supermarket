# typed: false

require 'spec_helper'
require_relative '../../../cashier/rules/manager'
require_relative '../../../cashier/rules/buy_one_get_one_free'
require_relative '../../../cashier/rules/discount'
require_relative '../../../cashier/rules/two_thirds'
require_relative '../../../cashier/items'

describe Cashier::Rules::Manager do
  let(:manager) { described_class.new }
  let(:rules) { manager.list }
  let(:action) { manager.evaluate(items:, rules:) }

  context 'list' do
    it 'returns the list of existing rules' do
      expect(manager.list.map(&:identifier)).to match_array(%w[buy_one_get_one_free discount two_thirds])
    end
  end

  context 'evaluate' do
    let(:coffee_item1) { Cashier::Items.find('CF1') }
    let(:strawberries_item1) { Cashier::Items.find('SR1') }
    let(:strawberries_item2) { Cashier::Items.find('SR1') }
    let(:green_tea_item) { Cashier::Items.find('GR1') }
    let(:coffee_item2) { Cashier::Items.find('CF1') }
    let(:coffee_item3) { Cashier::Items.find('CF1') }

    let(:items) do
      [
        coffee_item1,
        strawberries_item1,
        strawberries_item2,
        green_tea_item,
        coffee_item2,
        coffee_item3
      ]
    end

    it 'filters the items and call the evaluator for BuyOneGetOneFree' do
      expect(Cashier::Rules::BuyOneGetOneFree).to receive(:evaluate)
        .with(contain_exactly(green_tea_item))
        .and_call_original
      action
    end

    it 'filters the items and call the evaluator for Discount' do
      expect(Cashier::Rules::Discount).to receive(:evaluate)
        .with(contain_exactly(strawberries_item1, strawberries_item2))
        .and_call_original
      action
    end

    it 'filters the items and call the evaluator for TwoThirds' do
      expect(Cashier::Rules::TwoThirds).to receive(:evaluate)
        .with(contain_exactly(coffee_item1, coffee_item2, coffee_item3))
        .and_call_original
      action
    end
  end
end
