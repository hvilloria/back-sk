require 'rails_helper'

RSpec.describe TrackingIdGenerator do
  context 'when today is the first day of the month' do
    let!(:time) { Time.zone.now.change(day: 1) }

    before { allow(Time).to receive(:now) { time } }

    context 'and there is not any tracking id generated for that day' do
      it 'returns the restarted value' do
        create(:order, created_at: Time.zone.yesterday)
        expect(described_class.new.start).to eq('0001')
      end
    end

    context 'and there is a tracking id generated' do
      before { create(:order) }
      it 'returns the previous value of the tracking_id order plus one' do
        expect(described_class.new.start.to_i).to eq(Order.last.tracking_id.to_i + 1)
      end
    end
  end

  context 'when today is not the first day of the month' do
    let!(:time) { Time.zone.now.change(day: rand(2..28)) }
    before do
      allow(Time).to receive(:now) { time }
      create(:order)
    end

    it 'returns the previous value plus one' do
      expect(described_class.new.start.to_i).to eq(Order.last.tracking_id.to_i + 1)
    end
  end
end
