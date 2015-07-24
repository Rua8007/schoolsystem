class AddColumnsToStudentAttendaces < ActiveRecord::Migration
  def change
  	remove_column :student_attendances, :epresent
  	remove_column :student_attendances, :eleave

  	add_column :student_attendances, :epresent, :boolean, :default => true 

  	add_column :student_attendances, :eleave, :boolean, :default => false

  end
end
