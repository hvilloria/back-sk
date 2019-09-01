require 'rails_helper'

RSpec.describe Api::ProductsController, type: :controller do
  describe 'PATCH #update' do
    let(:category) { create(:category) }
    let(:product) { create(:product, category: category) }
    before do
      patch :update, params: { id: product.id, product: request_params }
      product.reload
    end

    context 'whit correct params' do
      let(:request_params) { { name: 'new name', price: 2500 } }

      it 'updates the product' do
        expect(product.name).to eql(request_params[:name])
        expect(product.price).to eql(request_params[:price].to_f)
      end
      it 'responds with status ok' do
        expect(response).to have_http_status(:ok)
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
      let(:request_params) { { name: 'new name'} }

      it 'responds with not found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns an error message' do
        expect(response.body.to_json).to include('error')
      end
    end
  end
end
