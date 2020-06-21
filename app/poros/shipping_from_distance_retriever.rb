class ShippingFromDistanceRetriever
  def call(distance, order)
    return 0 unless order.dl?

    if distance
      Shipping.find_by(distance: '3km').value
    else
      Shipping.find_by(distance: 'inside_range').value
    end
  end
end
