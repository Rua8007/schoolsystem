class CreateMarksheets < ActiveRecord::Migration
  def change
    create_table :marksheets do |t|
      t.integer :exam_id
      t.integer :bridge_id
      t.integer :totalmarks
      t.float :obtainedmarks
      t.integer :student_id

      t.timestamps null: false
    end
  end
end
