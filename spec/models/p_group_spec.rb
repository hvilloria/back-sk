require 'rails_helper'

RSpec.describe PGroup, type: :model do
  it { is_expected.to validate_presence_of(:kind) }
  it { is_expected.to belong_to(:promotion) }
  it { is_expected.to have_and_belong_to_many(:products) }
end
