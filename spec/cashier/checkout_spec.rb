require 'spec_helper'
require_relative '../../cashier/checkout'
require_relative '../../cashier/items'

describe Cashier::Checkout do
  let(:rules) { [] }
  let(:first_item) { Cashier::Items.find('GR1') }
  let(:second_item) { Cashier::Items.find('SR1') }
  let(:third_item) { Cashier::Items.find('GR1') }

  let(:checkout) { described_class.new(rules) }

  context 'Add items' do
    before do
      checkout.scan(first_item)
      checkout.scan(second_item)
      checkout.scan(third_item)
    end

    it 'the list returns the correct items' do
      expect(checkout.items.map(&:code)).to match_array(
        [first_item.code, second_item.code, third_item.code]
      )
    end
  end

  context 'Remove items' do
    before do
      checkout.scan(first_item)
      checkout.scan(second_item)
      checkout.scan(third_item)
      checkout.remove(first_item.code)
    end

    it 'the list returns the correct items' do
      expect(checkout.items.map(&:code)).to match_array(
        [second_item.code, third_item.code]
      )
    end
  end

  describe 'total' do
    context 'GR1,SR1,GR1,GR1,CF1' do
      before do
        checkout.scan(Cashier::Items.find('GR1'))
        checkout.scan(Cashier::Items.find('SR1'))
        checkout.scan(Cashier::Items.find('GR1'))
        checkout.scan(Cashier::Items.find('GR1'))
        checkout.scan(Cashier::Items.find('CF1'))
      end

      it 'calculates the correct amount' do
        expect(checkout.total).to eq('£22.45')
      end
    end

    context 'GR1,GR1' do
      before do
        checkout.scan(Cashier::Items.find('GR1'))
        checkout.scan(Cashier::Items.find('GR1'))
      end

      it 'calculates the correct amount' do
        expect(checkout.total).to eq('£3.11')
      end
    end

    context 'SR1,SR1,GR1,SR1' do
      before do
        checkout.scan(Cashier::Items.find('SR1'))
        checkout.scan(Cashier::Items.find('SR1'))
        checkout.scan(Cashier::Items.find('GR1'))
        checkout.scan(Cashier::Items.find('SR1'))
      end

      it 'calculates the correct amount' do
        expect(checkout.total).to eq('£16.61')
      end
    end

    context 'GR1,CF1,SR1,CF1,CF1' do
      before do
        checkout.scan(Cashier::Items.find('GR1'))
        checkout.scan(Cashier::Items.find('CF1'))
        checkout.scan(Cashier::Items.find('SR1'))
        checkout.scan(Cashier::Items.find('CF1'))
        checkout.scan(Cashier::Items.find('CF1'))
      end

      it 'calculates the correct amount' do
        expect(checkout.total).to eq('£30.57')
      end
    end
  end
end
