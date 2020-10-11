require 'rails_helper'

RSpec.describe Category, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:status) }
  it { is_expected.to have_many(:products) }
  it { is_expected.to have_one(:discount) }

  context 'using scopes' do
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

  describe '#change_products_status' do
    context 'when the category is active' do
      let!(:category) { create(:category, status: 'active') }

      context 'and gets inactivated' do
        context 'and products are active' do
          let!(:product) { create(:product, status: 'active', category: category) }

          it 'inactivates all its products' do
            category.inactive!
            expect(product.reload.status).to eq('inactive')
          end
        end

        context 'and products are inactive' do
          let!(:product) { create(:product, status: 'inactive', category: category) }

          it 'does not change the products status' do
            category.inactive!
            expect(product.reload.status).to eq('inactive')
          end
        end
      end
    end

    context 'when the category is inactive' do
      let!(:category) { create(:category, status: 'inactive') }

      context 'and gets activated' do
        context 'and products are active' do
          let!(:product) { create(:product, status: 'active', category: category) }

          it 'does not change the products status' do
            category.active!
            expect(product.reload.status).to eq('active')
          end
        end

        context 'and products are inactive' do
          let!(:product) { create(:product, status: 'inactive', category: category) }

          it 'activates its products' do
            category.active!
            expect(product.reload.status).to eq('active')
          end
        end
      end
    end
  end
end
