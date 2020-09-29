class CreatePGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :p_groups do |t|
      t.references :promotion, foreign_key: true
      t.references :variant, foreign_key: true

      t.timestamps
    end
  end
end
