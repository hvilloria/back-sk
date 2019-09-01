class TrackingIdGenerator
  attr_reader :base_date
  # TODO: TODA ESTA LOGICA DEBE SER REFACTORIZADA
  def initialize
    @base_date = set_first_day_of_the_month
  end

  def start
    return '0001' unless last_tracking_id.present?

    if start_of_month? then
      if Time.at(last_tracking_id.created_at).today? then
        return (last_tracking_id + 1).to_s
      else
        return '0001'
      end
    else
      return (last_tracking_id + 1).to_s
    end
  end

  def last_tracking_id
    @last_tracking_id ||= Order.last&.tracking_id&.to_i
  end

  def set_first_day_of_the_month
    t = Time.zone.now
    t.change(day: 1)
  end

  def start_of_month?
    base_date.day == 1
  end
end
