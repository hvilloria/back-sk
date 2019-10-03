class AddStatusToVariants < ActiveRecord::Migration[5.2]
  def change
    add_column :variants, :status, :string, null: false, default: 'active'
  end
end
