require 'rails_helper'

RSpec.describe Product, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:price) }
  it { is_expected.to belong_to(:category) }

  context 'when there is not presentation' do
    let(:category) { create(:category) }
    subject { described_class.new(name: 'random name', price: 12, category_id: category.id) }
    it 'is valid' do
      expect(subject).to be_valid
    end
  end
end
