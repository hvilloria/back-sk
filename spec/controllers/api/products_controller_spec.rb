require 'rails_helper'

RSpec.describe Api::ProductsController, type: :controller do
  include_context 'logged_user'
  describe 'PATCH #update' do
    let(:category) { create(:category) }
    let(:product) { create(:product, category: category) }
    before do
      patch :update, params: { id: product.id, product: request_params }
      product.reload
    end

    context 'with correct params' do
      let(:request_params) { { name: 'new name' } }

      it 'updates the product' do
        expect(product.name).to eql(request_params[:name])
      end
      it 'responds with status ok' do
        expect(response).to have_http_status(:ok)
      end

      context 'and updating variants' do
        let!(:variant) { create(:variant, product: product) }
        let(:request_params) do
          {
            name: 'new name',
            variants_attributes: [
              {
                id: variant.id,
                name: 'updated name'
              }
            ]
          }
        end

        it 'updates the variant' do
          expect(product.variants.first.name)
            .to eq(request_params[:variants_attributes].first[:name])
        end
      end
    end

    context 'with wrong params' do
      let(:request_params) { { name: '' } }

      it 'does not update the product' do
        expect(product).to eql(Product.find(product.id))
      end
      it 'responds with bad request' do
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'with an invalid product id' do
      before do
        patch :update, params: { id: 5, product: request_params }
        product.reload
      end
      let(:request_params) { { name: 'new name' } }

      it 'responds with not found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns an error message' do
        expect(response.body.to_json).to include('error')
      end
    end
  end
end
