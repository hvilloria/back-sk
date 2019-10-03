class RemoveClientFromOrders < ActiveRecord::Migration[5.2]
  def change
    remove_reference(:orders, :client, references: :user, index: true,
                                       foreign_key: { to_table: :users })
  end
end
