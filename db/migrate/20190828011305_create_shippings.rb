class CreateShippings < ActiveRecord::Migration[5.2]
  def change
    create_table :shippings do |t|
      t.integer :value, null: false

      t.timestamps
    end
  end
end
