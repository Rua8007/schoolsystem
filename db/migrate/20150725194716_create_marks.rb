class CreateMarks < ActiveRecord::Migration
  def change
    create_table :marks do |t|
      t.string :name
      t.float :marks
      t.float :passing_marks
      t.integer :grade_id

      t.timestamps null: false
    end
  end
end
