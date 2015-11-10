class AddMaxNoOfStudentsToGrades < ActiveRecord::Migration
  def change
    add_column :grades, :max_no_of_students, :integer
  end
end
