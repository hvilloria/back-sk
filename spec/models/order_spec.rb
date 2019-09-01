require 'rails_helper'

RSpec.describe Order, type: :model do
  it { is_expected.to belong_to(:client) }
  it { is_expected.to have_and_belong_to_many(:products) }

  it { is_expected.to validate_presence_of(:client) }
  it { is_expected.to validate_presence_of(:products) }
  it { is_expected.to validate_presence_of(:service_type) }
  it { is_expected.to validate_presence_of(:total) }
end
