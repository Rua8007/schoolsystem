class AddColumnToStudents < ActiveRecord::Migration
  def change
    add_column :students, :temporary, :boolean
  end
end
