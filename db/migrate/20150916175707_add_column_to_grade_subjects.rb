class AddColumnToGradeSubjects < ActiveRecord::Migration
  def change
    add_column :grade_subjects, :day_name_eng, :string
  end
end
