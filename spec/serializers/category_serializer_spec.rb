require 'rails_helper'

RSpec.describe Api::CategorySerializer, type: :serializer do
  let(:category) { create(:category) }
  let(:serializer) { described_class.new(category) }
  let(:serialization) { ActiveModelSerializers::Adapter.create(serializer) }
  subject { JSON.parse(serialization.to_json) }

  CATEGORY_SERIALIZER_FIELDS = %w[name status].freeze

  CATEGORY_SERIALIZER_FIELDS.each do |field|
    it "serializes the #{field.humanize(capitalize: false)} field" do
      expect(serializer.serializable_hash[field.to_sym]).to eq category.send(field)
    end
  end
end
