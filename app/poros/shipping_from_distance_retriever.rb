class ShippingFromDistanceRetriever
  def call(distance, order)
    return 0 if !order.dl?

    distance ? Shipping.find_by(distance: '3km').value :
      Shipping.find_by(distance: 'inside_range').value
  end
end