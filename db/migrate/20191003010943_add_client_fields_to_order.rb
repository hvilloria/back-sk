class AddClientFieldsToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :client_name, :string
    add_column :orders, :client_phone_number, :string
  end
end
