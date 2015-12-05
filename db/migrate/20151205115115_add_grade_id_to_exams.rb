class AddGradeIdToExams < ActiveRecord::Migration
  def change
    add_column :exams, :grade_id, :integer
  end
end
