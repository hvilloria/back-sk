require 'rails_helper'

RSpec.describe Api::PromotionsController, type: :controller do
  include_context 'logged_user'

  describe 'GET #index' do
    context 'when there are promotions created' do
      let!(:promotions) { create_list(:promotion, 5) }

      before do
        get :index
      end

      it 'responds with a not empty array' do
        expect(response_body).not_to be_empty
      end

      it 'responds with the list of promotions' do
        expected = ActiveModel::Serializer::CollectionSerializer.new(
          promotions, serializer: PromotionSerializer
        ).to_json
        expect(response.body).to eq expected
      end

      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end

      it 'responds with all the promotions' do
        expect(response_body.length).to eq promotions.count
      end
    end

    context 'when there are not promotions created' do
      before { get :index }

      it 'returns an empty array' do
        expect(response_body).to eq([])
      end

      it 'responds with status ok' do
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'GET #show' do
    context 'when given a correct ID' do
      let!(:promotion) { create(:promotion) }

      before do
        get :show, params: { id: promotion.id }
      end

      it 'responds with 200 status' do
        expect(response).to have_http_status(:ok)
      end

      it 'responds with a promotion json' do
        expect(response.body).to eq PromotionSerializer.new(
          promotion
        ).to_json
      end
    end

    context 'when given a non-existent ID' do
      before do
        get :show, params: { id: 1 }
      end

      it 'responds with an error message' do
        expect(response_body).to have_key(:error)
      end

      it 'responds with 404 status' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST #create' do
    subject(:create_promotion) do
      post :create, params: { promotion: request_params }
    end

    context 'with correct params' do
      let(:promotion) { build(:promotion) }
      let(:p_group) { build(:p_group) }
      let(:request_params) { promotion.attributes.merge(p_groups: [p_group]) }

      it 'creates the promotion' do
        expect { create_promotion }.to change { Promotion.count }.by(1)
      end

      it 'responds with status created' do
        create_promotion
        expect(response).to have_http_status(:created)
      end
    end

    context 'with wrong params' do
      let(:request_params) { { kind: nil } }

      it 'does not create the promotion' do
        expect { create_promotion }.not_to change(Promotion, :count)
      end

      it 'responds with bad request' do
        create_promotion
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'PATCH #update' do
    let(:promotion) { create(:promotion) }

    subject(:update_promotion) do
      patch :update, params: { id: promotion.id, promotion: request_params }
      promotion.reload
    end

    context 'with correct params' do
      let(:request_params) { { kind: 'two_for_one' } }

      it 'updates the promotion' do
        update_promotion
        expect(promotion.kind).to eql(request_params[:kind])
      end

      it 'responds with status ok' do
        update_promotion
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with wrong params' do
      let(:request_params) { { kind: nil } }

      it 'does not update the promotion' do
        update_promotion
        expect(promotion).to eql(Promotion.find(promotion.id))
      end

      it 'responds with bad request' do
        update_promotion
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'with an invalid promotion id' do
      subject(:update_promotion) do
        patch :update, params: { id: 5, promotion: request_params }
      end

      let(:request_params) { { kind: 'two_for_one' } }

      it 'responds with not found' do
        update_promotion
        expect(response).to have_http_status(:not_found)
      end

      it 'returns an error message' do
        update_promotion
        expect(response_body).to have_key(:error)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when given a correct ID' do
      let!(:promotion) { create(:promotion) }

      subject(:delete_promotion) do
        delete :destroy, params: { id: promotion.id }
      end

      it 'removes the promotion' do
        expect { delete_promotion }.to change { Promotion.count }.by(-1)
      end

      it 'responds with 200 status' do
        delete_promotion
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when given a non-existent ID' do
      subject(:delete_promotion) do
        delete :destroy, params: { id: 1 }
      end

      it 'does not removes the promotion' do
        expect { delete_promotion }.not_to change(Promotion, :count)
      end

      it 'responds with an error message' do
        delete_promotion
        expect(response_body).to have_key(:error)
      end

      it 'responds with 404 status' do
        delete_promotion
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
