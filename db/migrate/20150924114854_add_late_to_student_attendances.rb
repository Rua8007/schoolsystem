class AddLateToStudentAttendances < ActiveRecord::Migration
  def change
    add_column :student_attendances, :late, :boolean ,:default => false
  end
end
