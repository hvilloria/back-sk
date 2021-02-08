require 'rails_helper'

RSpec.describe Promotion, type: :model do
  it { is_expected.to validate_presence_of(:status) }
  it { is_expected.to validate_presence_of(:from_date) }
  it { is_expected.to validate_presence_of(:to_date) }
  it { is_expected.to validate_presence_of(:frequency) }
  it { is_expected.to validate_presence_of(:kind) }
  it { is_expected.to have_many(:p_groups) }

  context 'when using scopes' do
    before do
      create(:promotion, status: 'inactive')
      create_list(:promotion, 5)
    end

    context 'when using active_ones scope' do
      it 'shows only the active promotions' do
        expect(described_class.active_ones.size).to eq(5)
      end
    end
  end
end
