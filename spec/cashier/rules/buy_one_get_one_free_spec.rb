require 'spec_helper'
require_relative '../../cashier/checkout'
require_relative '../../cashier/items'

describe Cashier::Rules::BuyOneGetOneFree do
  let(:rule) { described_class.new }

  describe 'buy-one-get-one-free' do
    context 'when we only have one item' do
      let(:items) { [Cashier::Items.find('GR1')] }
      let(:expected_price) { items.first[:price][:cents] }

      it 'returns the normal price' do
        expect(rule.evaluate).to eq(expected_price)
      end
    end

    context 'when we only have two items' do
      let(:items) { [Cashier::Items.find('GR1')] }
      let(:expected_price) { items.first[:price][:cents] }

      it 'returns the price of one item' do
        expect(rule.evaluate).to eq(expected_price)
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
      let(:expected_price) { 3 * items.first[:price][:cents] }

      it 'returns the normal price' do
        expect(rule.evaluate).to eq(expected_price)
      end
    end
  end
end
