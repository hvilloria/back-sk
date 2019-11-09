require 'rails_helper'

RSpec.describe Order, type: :model do
  it { is_expected.to have_and_belong_to_many(:variants) }

  it { is_expected.to validate_presence_of(:variants) }
  it { is_expected.to validate_presence_of(:service_type) }
  it { is_expected.to validate_presence_of(:total) }
  it { is_expected.to validate_presence_of(:payment_type) }

  context 'when the service is pedidos ya' do
    it 'does not generate a tracking id' do
      expect(TrackingIdGenerator).not_to receive(:new)
      create(:order, :pedidos_ya_service)
    end
  end

  context 'when is not an external service' do
    it 'generates a tracking id' do
      expect(TrackingIdGenerator).to receive_message_chain(:new, :start)
      create(:order)
    end
  end

  context 'when using scopes' do
    before do
      create_list(:order, 5)
      Order.last.update(created_at: Time.zone.now - 2.day)
    end

    context 'when using today_ones scope' do
      it 'shows only the today orders' do
        expect(described_class.today_ones.size).to eq(4)
      end
    end
  end
end
