require 'rails_helper'

RSpec.describe Variant, type: :model do
  it { is_expected.to belong_to(:product) }
  it { is_expected.to validate_presence_of(:price) }
  it { is_expected.to validate_presence_of(:name) }

  let(:variant) do
    build(:variant,
          name: name,
          base: base,
          product: Product.last)
  end

  before do
    create(:category)
    create(:product, category: Category.last)
  end

  context 'when the variant is not the base one' do
    let(:base) { false }
    context 'and the name is null' do
      let(:name) { nil }
      it 'is not valid' do
        expect(variant).not_to be_valid
      end
    end

    context 'and the name is not null' do
      let(:name) { Faker::Name.name }
      it 'is valid' do
        expect(variant).to be_valid
      end
    end
  end

  context 'when the variant is the base one' do
    let(:base) { true }
    context 'and the name is null' do
      let(:name) { nil }
      it 'is valid' do
        expect(variant).to be_valid
      end
    end
    context 'and the name is not null' do
      let(:name) { '15 piezas' }
      it 'is not valid' do
        expect(variant).not_to be_valid
      end
    end
  end
end
