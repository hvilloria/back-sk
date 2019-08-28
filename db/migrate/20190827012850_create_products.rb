class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.float :price, null: false
      t.string :status, null: false, default: 'active'
      t.references :category, foreign_key: true
      t.integer :presentation

      t.timestamps
    end
  end
end
