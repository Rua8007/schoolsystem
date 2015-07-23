class RemoveColumnFromStudent < ActiveRecord::Migration
  def change
    remove_column :students, :dueDate, :string
    add_column :students, :due_date, :string
  end
end
