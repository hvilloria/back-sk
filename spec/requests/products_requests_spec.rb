require 'rails_helper'

RSpec.describe 'Products requests' do
  include_context 'logged_user'

  describe 'PATCH #update' do
    let(:category) { create(:category) }
    let(:product) { create(:product, category: category) }

    before do
      patch "/api/products/#{product.id}", params: { product: request_params }, headers: @tokens
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
                name: 'updated name',
                price: 200
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
        patch "/api/products/#{50}", params: { product: request_params }, headers: @tokens
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

  describe 'POST #create' do
    context 'when some params are not present' do
      let(:request_params_without_category_id) do
        {
          'product': {
            "name": 'new product',
            "status": 'active',
            "variants_attributes": [{
              "base": false,
              "name": 'a variant of that product',
              "price": 123.6,
              "status": 'active'
            }]
          }
        }
      end

      before { post "/api/products", params: request_params_without_category_id, headers: @tokens }

      it 'returns a bad request status' do
        expect(response).to have_http_status(:bad_request)
      end

      it 'returns the error message' do
        expect(response_body[:error][:category]).to include('must exist')
      end
    end

    context 'when all params are present' do
      let!(:category) { create(:category) }

      let(:all_params_present) do
        {
          'product': {
            'name': 'new product',
            'status': 'active',
            'category_id': category.id,
            'variants_attributes': [{
              'base': false,
              'name': 'a variant of that product',
              "price": 123.6,
              'status': 'active'
            }]
          }
        }
      end

      before { post '/api/products', params: all_params_present, headers: @tokens }

      it 'responds with status created' do
        expect(response).to have_http_status(:created)
      end

      it 'returns the product object serialized' do
        expect(response_body).to include(:id)
      end
    end
  end
end
