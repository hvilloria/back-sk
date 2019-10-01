class AddStatusToVariants < ActiveRecord::Migration[5.2]
  def change
    add_column :variants, :status, :string, default: 'active'
  end
end
