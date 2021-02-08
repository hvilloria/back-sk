require 'rails_helper'

RSpec.describe PGroup, type: :model do
  it { is_expected.to belong_to(:promotion) }
  it { is_expected.to belong_to(:variant) }
end
