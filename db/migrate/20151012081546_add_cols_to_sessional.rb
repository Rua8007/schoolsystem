class AddColsToSessional < ActiveRecord::Migration
  def change
    add_column :sessionals, :bridge_id, :integer
    add_column :sessionals, :student_id, :integer
    add_column :sessionals, :total, :float
    add_column :sessionals, :exam_id, :integer
  end
end
