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

  describe 'POST #create' do
    subject(:create_category) do
      post :create, params: { category: request_params }
    end

    context 'with correct params' do
      let(:request_params) { attributes_for(:category) }

      it 'creates the category' do
        expect { create_category }.to change { Category.count }.by(1)
      end
      it 'responds with status created' do
        create_category
        expect(response).to have_http_status(:created)
      end
    end

    context 'with wrong params' do
      let(:request_params) { { name: '' } }

      it 'does not create the category' do
        expect { create_category }.not_to change(Category, :count)
      end
      it 'responds with bad request' do
        create_category
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'PATCH #update' do
    let(:category) { create(:category) }
    before do
      patch :update, params: { id: category.id, category: request_params }
      category.reload
    end

    context 'with correct params' do
      let(:request_params) { { name: 'new name', status: 'inactive' } }

      it 'updates the category' do
        expect(category.name).to eql(request_params[:name])
        expect(category.status).to eql(request_params[:status])
      end
      it 'responds with status ok' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with wrong params' do
      let(:request_params) { { name: '' } }

      it 'does not update the category' do
        expect(category).to eql(Category.find(category.id))
      end
      it 'responds with bad request' do
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'with an invalid category id' do
      before do
        patch :update, params: { id: 5, category: request_params }
        category.reload
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
