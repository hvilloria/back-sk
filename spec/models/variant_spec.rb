require 'rails_helper'

RSpec.describe Variant, type: :model do
  it { is_expected.to belong_to(:product) }
  it { is_expected.to validate_presence_of(:price) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:status) }

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

  context 'when using scopes' do
    let(:category) { create(:category) }
    let(:product) { create(:product, category: category) }
    before do
      create(:variant, status: 'inactive', product: product)
      create_list(:variant, 4, product: product)
    end

    context 'when using active_ones scope' do
      it 'shows only the active variants' do
        expect(described_class.active_ones.size).to eq(4)
      end
    end

    context 'when using inactive_ones scope' do
      it 'shows only the inactive variants' do
        expect(described_class.inactive_ones.size).to eq(1)
      end
    end
  end
end
