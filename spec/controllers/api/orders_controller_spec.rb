require 'rails_helper'

RSpec.describe Api::OrdersController, type: :controller do
  describe '#create' do
    before do
      create(:user)
      create(:category)
      create_list(:product, 2, category: Category.last)
      post :create, params: params
    end

    context 'when some params are missing' do
      let(:params) do
        {
          'order': {
            'client_id': nil,
            'product_ids': [Product.first, Product.second],
            'tracking_id': '1322',
            'service_type': 'pedidos ya',
            'total': 3123.23,
            'notes': 'sin notas'

          }
        }
      end

      it 'returns status bad_request' do
        expect(response).to have_http_status(:bad_request)
      end
    end
    context 'when params are present' do
      let(:params) do
        {
          'order': {
            'client_id': User.first,
            'product_ids': [Product.first, Product.second],
            'tracking_id': '1322',
            'service_type': 'pedidos ya',
            'total': 3123.23,
            'notes': 'sin notas'

          }
        }
      end
      it 'returns status created' do
        expect(response).to have_http_status(:created)
      end
    end
  end
end
