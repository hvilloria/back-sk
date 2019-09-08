require 'rails_helper'

RSpec.describe Api::ProductSerializer, type: :serializer do
  let(:category) { create(:category) }
  let(:product) { create(:product, category: category) }
  let(:serializer) { described_class.new(product) }
  let(:serialization) { ActiveModelSerializers::Adapter.create(serializer) }
  subject { JSON.parse(serialization.to_json) }

  PRODUCT_SERIALIZER_FIELDS = %w[name presentation status].freeze

  PRODUCT_SERIALIZER_FIELDS.each do |field|
    it "serializes the #{field.humanize(capitalize: false)} field" do
      expect(serializer.serializable_hash[field.to_sym]).to eq product.send(field)
    end
  end
end
