class CreateStudentHolidays < ActiveRecord::Migration
  def change
    create_table :student_holidays do |t|
      t.string :reason
      t.text :description
      t.integer :student_id
      t.date :leave_from
      t.date :leave_to
      t.boolean :approved, :default => false

      t.timestamps null: false
    end
  end
end
