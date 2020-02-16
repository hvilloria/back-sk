class AddDescriptionToVariants < ActiveRecord::Migration[5.2]
  def change
    add_column :variants, :description, :text
  end
end
