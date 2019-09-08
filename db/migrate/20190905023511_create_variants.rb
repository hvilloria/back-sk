class CreateVariants < ActiveRecord::Migration[5.2]
  def change
    create_table :variants do |t|
      t.float :price
      t.string :name
      t.boolean :base, null: false
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
