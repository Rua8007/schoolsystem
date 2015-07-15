class CreateEmployeeAttendances < ActiveRecord::Migration
  def change
    create_table :employee_attendances do |t|
      t.integer :employee_id
      t.date :attendance_date
      t.boolean :epresent, :default => true 
      t.boolean :eleave, :default => false

      t.timestamps null: false
    end
  end
end
