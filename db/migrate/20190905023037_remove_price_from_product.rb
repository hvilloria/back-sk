class RemovePriceFromProduct < ActiveRecord::Migration[5.2]
  def change
    remove_column :products, :price, :float
  end
end
