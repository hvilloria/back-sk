RSpec.describe 'Order requests' do
  include_context 'logged_user'
  fixtures :categories, :products, :variants

  describe 'POST /api/orders' do
    before do
      Shipping.create!(distance: 'inside_range', value: 0)
      Shipping.create!(distance: '3km', value: 100)
    end

    subject { post '/api/orders', params: params, headers: @tokens }

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
          },
          'distance': true
        }
      end

      it 'returns status bad_request' do
        subject
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
              { 'variant_id': Variant.last.id, 'price': Variant.last.price }
            ]
          },
          'distance': true
        }
      end

      it 'returns status created' do
        subject
        expect(response).to have_http_status(:created)
      end
    end

    context 'working with promotions' do
      context 'when there is a percentage promo on current day' do
        let(:current_day) { Time.parse('06/10/2020') }
        let(:wrap_shrimp) { Variant.last }

        let(:params) do
          {
            order: attributes_for(:order).merge(
              order_details_attributes: [build(:order_detail, variant: wrap_shrimp).as_json]
            )
          }
        end

        before do
          travel_to current_day
          create(
            :promotion,
            frequency: ['tuesday'],
            value: 50,
            from_date: Time.zone.now,
            to_date: Time.zone.now
           )
        end

        it 'creates a new order' do
          expect { subject }.to change { Order.count }.from(0).to(1)
        end

        it 'creates a new order detail' do
          expect { subject }.to change { OrderDetail.count }.from(0).to(1)
        end

        it 'sets the price as the promotion percetage defines' do
          subject
          expect(OrderDetail.last.price).to eq(160)
        end

        it 'sums all the order details price to set it as total for order' do
          subject
          expect(Order.last.total).to eq(160)
        end
      end
    end
  end

  describe 'GET /api/orders' do
    context 'when there are not orders created' do
      before { get '/api/orders', headers: @tokens }
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
      before { get '/api/orders', headers: @tokens }
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
