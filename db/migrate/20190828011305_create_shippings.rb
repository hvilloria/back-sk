class CreateShippings < ActiveRecord::Migration[5.2]
  def change
    create_table :shippings do |t|
      t.references :category, foreign_key: true
      t.references :product, foreign_key: true
      t.integer :value, null: false

      t.timestamps
    end
  end
end
