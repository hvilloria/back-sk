class PriceValidator < ActiveModel::Validator
  def validate(record)
    unless record.price == record.variant.price
      record.errors[:price] << 'price of detail must be the same as the variant price'
    end
  end
end