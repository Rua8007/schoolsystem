class CreateMarksDivisions < ActiveRecord::Migration
  def change
    create_table :marks_divisions do |t|
      t.string :name
      t.float :passing_marks
      t.float :total_marks
      t.boolean :is_divisible
      t.belongs_to :grade_group

      t.timestamps null: false
    end
  end
end
