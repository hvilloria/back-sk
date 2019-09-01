class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :tracking_id
      t.references :client, references: :users, foreign_key: { to_table: :users }
      t.string :service_type
      t.integer :shipping_cost, default: 0
      t.float :total
      t.text :notes

      t.timestamps
    end
  end
end
