class CreatePromotions < ActiveRecord::Migration[5.2]
  def change
    create_table :promotions do |t|
      t.string :status, null: false, default: 'inactive'
      t.datetime :from_date, null: false, default: DateTime.current.change(hour: 18, min: 0)
      t.datetime :to_date, null: false, default: DateTime.new(DateTime.now.year, 12, 31, 23, 50)
      t.string :frequency, array: true, null: false
      t.string :kind, null: false, default: 'percentage'
      t.float :base_price
      t.integer :percentage

      t.timestamps
    end
  end
end
