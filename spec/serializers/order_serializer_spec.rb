require 'rails_helper'

RSpec.describe Api::OrderSerializer, type: :serializer do
  let(:order) { create(:order) }
  let(:serializer) { described_class.new(order) }
  let(:serialization) { ActiveModelSerializers::Adapter.create(serializer) }
  subject { JSON.parse(serialization.to_json) }

  ORDER_SERIALIZER_FIELDS = %w[tracking_id service_type shipping_cost total
                               notes created_at payment_type client_name
                               client_phone_number].freeze

  ORDER_SERIALIZER_FIELDS.each do |field|
    it "serializes the #{field.humanize(capitalize: false)} field" do
      expect(serializer.serializable_hash[field.to_sym]).to eq order.send(field)
    end
  end
end
