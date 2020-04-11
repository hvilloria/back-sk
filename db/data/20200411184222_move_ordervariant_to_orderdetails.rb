class MoveOrdervariantToOrderdetails < ActiveRecord::Migration[5.2]
  def up
    Order.all.each do |order|
      order.variants.each do |variant|
        OrderDetail.create!(order: order, variant: variant, price: variant.price)
      end
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
