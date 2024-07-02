require 'spec_helper'

describe Checkout do
  let(:rules) { [] }
  let(:first_item) { Items.find('GR1') }
  let(:second_item) { Items.find('SR1') }
  let(:third_item) { Items.find('GR1') }

  context 'Add items' do
    before do
      checkout.scan(first_item)
      checkout.scan(second_item)
      checkout.scan(third_item)
    end

    it 'the list returns the correct items' do
      expect(checkout.list_items.map(&:id)).to match_array[first_item.id, second_item.id, third_item.id]
    end
  end

  context 'Remove items' do
    before do
      checkout.scan(first_item)
      checkout.scan(second_item)
      checkout.scan(third_item)
      checkout.remove(first_item)
    end

    it 'the list returns the correct items' do
      expect(checkout.list_items.map(&:id)).to match_array[second_item.id, third_item.id]
    end
  end

  describe 'total' do
    context 'GR1,SR1,GR1,GR1,CF1' do
      before do
        context.scan(Items.find('GR1'))
        context.scan(Items.find('SR1'))
        context.scan(Items.find('GR1'))
        context.scan(Items.find('GR1'))
        context.scan(Items.find('CF1'))
      end

      it 'calculates the correct amount' do
        expect(checkout.total).to eq('£22.45')
      end
    end

    context 'GR1,GR1' do
      before do
        context.scan(Items.find('GR1'))
        context.scan(Items.find('GR1'))
      end

      it 'calculates the correct amount' do
        expect(checkout.total).to eq('£3.11')
      end
    end

    context 'GR1,GR1' do
      before do
        context.scan(Items.find('GR1'))
        context.scan(Items.find('GR1'))
      end

      it 'calculates the correct amount' do
        expect(checkout.total).to eq('£3.11')
      end
    end

    context 'SR1,SR1,GR1,SR1' do
      before do
        context.scan(Items.find('SR1'))
        context.scan(Items.find('SR1'))
        context.scan(Items.find('GR1'))
        context.scan(Items.find('SR1'))
      end

      it 'calculates the correct amount' do
        expect(checkout.total).to eq('£16.61')
      end
    end

    context 'GR1,CF1,SR1,CF1,CF1' do
      before do
        context.scan(Items.find('GR1'))
        context.scan(Items.find('CF1'))
        context.scan(Items.find('SR1'))
        context.scan(Items.find('CF1'))
        context.scan(Items.find('CF1'))
      end

      it 'calculates the correct amount' do
        expect(checkout.total).to eq('£30.57')
      end
    end
  end
end
