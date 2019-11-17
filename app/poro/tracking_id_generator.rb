class TrackingIdGenerator
  MAX_TRACKING_ID_LENGTH = 4
  INITIAL_VALUE = '0001'.freeze

  def start
    return INITIAL_VALUE unless last_tracking_id.present? && valid_moment_to_start?

    formatted_value
  end

  def valid_moment_to_start?
    last_tk_or_dl.created_at.today? || !start_of_month?
  end

  def formatted_value
    tracking_id = (last_tracking_id + 1).to_s
    tracking_id.tap { tracking_id.prepend('0') while tracking_id.length < MAX_TRACKING_ID_LENGTH }
  end

  def last_tracking_id
    @last_tracking_id ||= last_tk_or_dl&.tracking_id&.to_i
  end

  def last_tk_or_dl
    @last_tk_or_dl ||= Order.where(service_type: %i[dl tk]).last
  end

  def first_day_of_the_month
    @first_day_of_the_month ||= Time.zone.now.change(day: 1)
  end

  def start_of_month?
    first_day_of_the_month == Time.zone.now
  end
end
