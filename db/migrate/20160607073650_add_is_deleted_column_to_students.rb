class AddIsDeletedColumnToStudents < ActiveRecord::Migration
  def change
    add_column :students, :is_deleted, :boolean, default: false
  end
end
