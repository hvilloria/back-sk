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
            'variant_ids': [Variant.last.id],
            'tracking_id': '1322',
            'service_type': 'dl',
            'total': 3123.23,
            'notes': 'sin notas',
            'payment_type': 'cash',
            'client_name': 'Pedro',
            'client_phone_number': 'Perez'
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

  describe 'PATCH #modify_status' do
    before do
      create(:category)
      create(:product, category: Category.last)
      create(:variant, product: Product.last)
    end

    context 'when the status is not correct or is not valid' do
      before do
        create(:order, state: 'finished')
        patch :modify_status, params: params
      end
      let(:params) do
        {
          id: Order.last.id,
          status: 'cancel'
        }
      end

      it 'returns a json with the error' do
        expect(response_body).to include(:error)
      end

      it 'return an unprocessable_entity code' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when the status is valid' do
      before do
        create(:order)
        patch :modify_status, params: params
      end

      let(:params) do
        {
          id: Order.last.id,
          status: 'finish'
        }
      end
      it 'returns status ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns the order updated' do
        expect(response_body[:state]).to eq('finished')
      end
    end
  end
end
