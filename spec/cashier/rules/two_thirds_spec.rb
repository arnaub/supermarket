require 'spec_helper'
require_relative '../../cashier/checkout'
require_relative '../../cashier/items'

describe Cashier::Rules::BuyOneGetOneFree do
  let(:rule) { described_class.new }

  describe 'two thirds' do
    context 'when we have less than 3 items' do
      let(:items) { [Cashier::Items.find('CF1'), Cashier::Items.find('CF1')] }
      let(:expected_price) { items.map { |item| item[:price][:cents] } }

      it 'returns the normal price' do
        expect(rule.evaluate).to eq(expected_price)
      end
    end

    context 'when we have 3 items' do
      let(:items) do
        [
          Cashier::Items.find('CF1'),
          Cashier::Items.find('CF1'),
          Cashier::Items.find('CF1')
        ]
      end
      let(:price) { items.map { |item| item[:price][:cents] } }
      let(:expected_price) { price * 2 / 3 }

      it 'returns the normal price' do
        expect(rule.evaluate).to eq(expected_price)
      end
    end

    context 'when we have more than items' do
      let(:items) do
        [
          Cashier::Items.find('CF1'),
          Cashier::Items.find('CF1'),
          Cashier::Items.find('CF1'),
          Cashier::Items.find('CF1'),
          Cashier::Items.find('CF1')
        ]
      end
      let(:price) { items.map { |item| item[:price][:cents] } }
      let(:expected_price) { price * 2 / 3 }

      it 'returns the normal price' do
        expect(rule.evaluate).to eq(expected_price)
      end
    end
  end
end
