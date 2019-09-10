require 'rails_helper'

RSpec.describe Product, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:status) }
  it { is_expected.to belong_to(:category) }
  it { is_expected.to have_one(:discount) }
  it { is_expected.to have_and_belong_to_many(:orders) }

  context 'when there is not presentation' do
    let(:category) { create(:category) }
    subject do
      described_class.new(
        name: 'Hot Rolls',
        status: :active,
        category_id: category.id
      )
    end
    it 'is valid' do
      expect(subject).to be_valid
    end
  end

  context 'when using scopes' do
    let(:category) { create(:category) }
    before do
      create(:product, status: 'inactive', category: category)
      create_list(:product, 4, category: category)
    end

    context 'when using active_ones scope' do
      it 'shows only the active products' do
        expect(described_class.active_ones.size).to eq(4)
      end
    end

    context 'when using inactive_ones scope' do
      it 'shows only the inactive products' do
        expect(described_class.inactive_ones.size).to eq(1)
      end
    end
  end
end
