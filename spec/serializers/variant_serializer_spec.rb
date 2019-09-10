require 'rails_helper'

RSpec.describe Api::VariantSerializer, type: :serializer do
  let(:category) { create(:category) }
  let(:product) { create(:product, category: category) }
  let(:variant) { create(:variant, base: false, product: product) }
  let(:serializer) { described_class.new(variant) }
  let(:serialization) { ActiveModelSerializers::Adapter.create(serializer) }
  subject { JSON.parse(serialization.to_json) }

  VARIANT_SERIALIZER_FIELDS = %w[name price base].freeze

  VARIANT_SERIALIZER_FIELDS.each do |field|
    it "serializes the #{field.humanize(capitalize: false)} field" do
      expect(serializer.serializable_hash[field.to_sym]).to eq variant.send(field)
    end
  end
end
