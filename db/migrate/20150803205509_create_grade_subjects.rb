class CreateGradeSubjects < ActiveRecord::Migration
  def change
    create_table :grade_subjects do |t|
      t.integer :subject_id
      t.integer :grade_id
      t.integer :week_id
      t.string :dayname
      t.text :classwork
      t.text :homework

      t.timestamps null: false
    end
  end
end
