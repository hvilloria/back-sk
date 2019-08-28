require 'rails_helper'

RSpec.describe Shipping, type: :model do
  it { is_expected.to validate_presence_of(:value) }
end
