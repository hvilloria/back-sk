require 'rails_helper'

RSpec.describe Order, type: :model do
  it { is_expected.to belong_to(:client) }
  it { is_expected.to have_and_belong_to_many(:products) }

  it { is_expected.to validate_presence_of(:client) }
  it { is_expected.to validate_presence_of(:products) }
  it { is_expected.to validate_presence_of(:service_type) }
  it { is_expected.to validate_presence_of(:total) }

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
end
