class RemodelSessionals < ActiveRecord::Migration
  def change
    remove_column :sessionals, :marksheet_id, :integer
    remove_column :sessionals, :marks, :float

    add_column :sessionals, :sub_division_id, :integer
    add_column :sessionals, :total_marks, :float
    add_column :sessionals, :obtained_marks, :float
  end
end
