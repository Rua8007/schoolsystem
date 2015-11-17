class AddGradeGroupIdToGrade < ActiveRecord::Migration
  def change
    add_column :grades, :grade_group_id, :integer
  end
end
