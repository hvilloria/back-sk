class RemovePresentationFromProducts < ActiveRecord::Migration[5.2]
  def change
    remove_column :products, :presentation, :integer
  end
end
