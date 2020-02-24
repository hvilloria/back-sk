class RemoveStateFromOrders < ActiveRecord::Migration[5.2]
  def change
    remove_column :orders, :state
  end
end
