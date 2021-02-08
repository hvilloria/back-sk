class ApplyPromotions
  include Interactor

  def call
    return order if promotions.empty?

    order.order_details.each do |order_detail|
      promotion = promotions.find do |promotion|
        promotion.variants.pluck(:id).include? order_detail.variant_id
      end

      if promotion.price?
        order_detail.price = promotion.value
      else
        order_detail.price = (promotion.value * order_detail.price) / 100
      end
    end
    context.order = order
  end

  private

  def order
    @order ||= context.order
  end

  def promotions
    @promotions ||= Promotion.where("'#{Time.zone.now.strftime("%A")}' = ANY (frequency)")
                             .joins(p_groups: :variant)
                             .where(variants: { id: order.order_details.map(&:variant_id) })
  end
end
