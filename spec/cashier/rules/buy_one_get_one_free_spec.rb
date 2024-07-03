# typed: false

require 'spec_helper'
require_relative '../../../cashier/rules/buy_one_get_one_free'
require_relative '../../../cashier/items'

describe Cashier::Rules::BuyOneGetOneFree do
  let(:evaluate) { described_class.evaluate(items) }

  describe 'buy-one-get-one-free' do
    context 'when the items list is empty' do
      let(:items) { [] }

      it 'returns 0' do
        expect(evaluate).to eq(0)
      end
    end

    context 'when we only have one item' do
      let(:items) { [Cashier::Items.find('GR1')] }
      let(:expected_price) { items.first.price.cents }

      it 'returns the normal price' do
        expect(evaluate).to eq(expected_price)
      end
    end

    context 'when we only have two items' do
      let(:items) { [Cashier::Items.find('GR1')] }
      let(:expected_price) { items.first.price.cents }

      it 'returns the price of one item' do
        expect(evaluate).to eq(expected_price)
      end
    end

    context 'when we only have more than two items' do
      let(:items) do
        [
          Cashier::Items.find('GR1'),
          Cashier::Items.find('GR1'),
          Cashier::Items.find('GR1'),
          Cashier::Items.find('GR1'),
          Cashier::Items.find('GR1')
        ]
      end
      let(:expected_price) { 3 * items.first.price.cents }

      it 'returns the normal price' do
        expect(evaluate).to eq(expected_price)
      end
    end
  end
end
