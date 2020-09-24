require 'rails_helper'

RSpec.describe OrderDetail, type: :model do
  let(:variant) { build_stubbed(:variant) }
  let(:order) { build_stubbed(:order) }
  let(:order_detail) { build_stubbed(:order_detail, variant: variant, order: order) }

  it { is_expected.to belong_to(:variant) }
  it { is_expected.to belong_to(:order) }
  it { is_expected.to validate_presence_of(:price) }

  it 'the price is equal to the variant price' do
    expect(order_detail.price).to eq(variant.price)
  end
end
