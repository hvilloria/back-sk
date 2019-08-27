class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.string :status, null: false, default: 'available'

      t.timestamps
    end
  end
end
