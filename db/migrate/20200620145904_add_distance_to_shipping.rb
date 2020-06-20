class AddDistanceToShipping < ActiveRecord::Migration[5.2]
  def change
    add_column :shippings, :distance, :string
  end
end
