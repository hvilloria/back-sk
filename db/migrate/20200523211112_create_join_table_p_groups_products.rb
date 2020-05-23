class CreateJoinTablePGroupsProducts < ActiveRecord::Migration[5.2]
  def change
    create_join_table :p_groups, :products do |t|
      t.index [:p_group_id, :product_id]
      t.index [:product_id, :p_group_id]
    end
  end
end
