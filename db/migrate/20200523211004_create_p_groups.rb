class CreatePGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :p_groups do |t|
      t.string :kind, null: false, default: 'sellable'
      t.references :promotion, foreign_key: true

      t.timestamps
    end
  end
end
