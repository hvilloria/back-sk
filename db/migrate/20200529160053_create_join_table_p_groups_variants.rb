class CreateJoinTablePGroupsVariants < ActiveRecord::Migration[5.2]
  def change
    create_join_table :p_groups, :variants do |t|
      t.index [:p_group_id, :variant_id]
      t.index [:variant_id, :p_group_id]
    end
  end
end
