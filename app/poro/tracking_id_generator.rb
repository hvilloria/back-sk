class TrackingIdGenerator
  attr_reader :base_date
  MAX_TRACKING_ID_LENGTH = 4
  INITIAL_VALUE = '0001'.freeze

  def start
    return INITIAL_VALUE unless last_tracking_id.present? && valid_moment_to_start?

    formatted_value
  end

  def valid_moment_to_start?
    last_order.created_at.today? || !start_of_month?
  end

  def formatted_value
    tracking_id = (last_tracking_id + 1).to_s
    tracking_id.tap { tracking_id.prepend('0') while tracking_id.length < MAX_TRACKING_ID_LENGTH }
  end

  def last_tracking_id
    @last_tracking_id ||= last_order&.tracking_id&.to_i
  end

  def last_order
    @last_order ||= Order.last
  end

  def first_day_of_the_month
    @first_day_of_the_month ||= Time.zone.now.change(day: 1)
  end

  def start_of_month?
    first_day_of_the_month == Time.zone.now
  end
end
