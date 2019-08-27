require 'rails_helper'

RSpec.describe Product, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:price) }
  it { is_expected.to validate_presence_of(:status) }
  it { is_expected.to belong_to(:category) }

  context 'when there is not presentation' do
    let(:category) { create(:category) }
    subject do
      described_class.new(
        name: 'Hot Rolls',
        price: 12,
        status: :active,
        category_id: category.id
      )
    end
    it 'is valid' do
      expect(subject).to be_valid
    end
  end
end
