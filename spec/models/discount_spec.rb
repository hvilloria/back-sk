require 'rails_helper'

RSpec.describe Discount, type: :model do
  it { is_expected.to validate_presence_of(:amount) }
  it { is_expected.to belong_to(:category) }
  it { is_expected.to belong_to(:product) }
end
