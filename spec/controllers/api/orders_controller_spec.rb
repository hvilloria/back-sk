require 'rails_helper'

RSpec.describe Api::OrdersController, type: :controller do
  include_context 'logged_user'
  describe 'POST #create' do
    before do
      create(:category)
      create(:product, category: Category.last)
      create(:variant, product: Product.last)
      Shipping.create!(value: 0)
      post :create, params: params
    end

    context 'when some params are missing' do
      let(:params) do
        {
          'order': {
            'variant_ids': [Variant.last.id],
            'tracking_id': '1322',
            'service_type': 'tk',
            'total': nil,
            'notes': 'sin notas',
            'payment_type': 'cash'
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
            'tracking_id': '1322',
            'service_type': 'dl',
            'total': 3123.23,
            'notes': 'sin notas',
            'payment_type': 'cash',
            'client_name': 'Pedro',
            'client_phone_number': 'Perez',
            'order_details_attributes': [
              {'variant_id': Variant.last.id, 'price': Variant.last.price},
          ]
          }
        }
      end
      it 'returns status created' do
        expect(response).to have_http_status(:created)
      end
    end
  end

  describe 'GET #index' do
    context 'when there are not orders created' do
      before { get :index }
      it 'returns an empty array' do
        body = JSON.parse(response.body)
        expect(body).to eq([])
      end
      it 'responds with status ok' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when there are orders created' do
      let!(:order) { create_list(:order, 5) }
      before { get :index }
      it 'returns a non empty array' do
        body = JSON.parse(response.body)
        expect(body).not_to be_empty
      end
      it 'responds with status ok' do
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
