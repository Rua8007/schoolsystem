class CreateStudentAttendances < ActiveRecord::Migration
  def change
    create_table :student_attendances do |t|
      t.integer :student_id
      t.date :attendance_date
      t.boolean :epresent
      t.boolean :eleave

      t.timestamps null: false
    end
  end
end
