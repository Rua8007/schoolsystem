class RenameGradeIdToGradeGroupIdInMarks < ActiveRecord::Migration
  def change
    rename_column :marks, :grade_id, :grade_group_id
  end
end
