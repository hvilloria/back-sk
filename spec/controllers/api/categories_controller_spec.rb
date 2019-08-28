require 'rails_helper'

RSpec.describe Api::CategoriesController, type: :controller do
  describe 'GET #index' do
    context 'when there are not categories created' do
      before { get :index }
      it 'returns an empty array' do
        body = JSON.parse(response.body)
        expect(body).to eq([])
      end
      it 'responds with status ok' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when there are categories created' do
      let(:category) { create(:category) }
      let!(:products) { create_list(:product, 5, category: category) }
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
