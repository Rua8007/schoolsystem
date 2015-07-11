class AddStudentToEmergency < ActiveRecord::Migration
  def change
    add_column :emergencies, :student_id, :integer
  end
end
