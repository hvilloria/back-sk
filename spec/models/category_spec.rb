require 'rails_helper'

RSpec.describe Category, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:status) }
  it { is_expected.to have_many(:products) }

  before do
    create_list(:category, 4)
    create(:category, status: 'inactive')
  end

  context 'when using active_ones scope' do
    it 'shows only the active categories' do
      expect(described_class.active_ones.size).to eq(4)
    end
  end

  context 'when using inactive_ones scope' do
    it 'shows only the inactive categories' do
      expect(described_class.inactive_ones.size).to eq(1)
    end
  end
end
