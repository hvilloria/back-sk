class CreateJoinTableOrdersVariants < ActiveRecord::Migration[5.2]
  def change
    create_join_table :orders, :variants do |t|
      t.index [:order_id, :variant_id]
      t.index [:variant_id, :order_id]
    end
  end
end
