class RemoveColumnCreatorIdOfDepartment < ActiveRecord::Migration
  def change
  	remove_column :departments, :creator_id
  end
end
