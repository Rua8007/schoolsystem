class DeleteLeaveDateFromLeave < ActiveRecord::Migration
  def change
    remove_column :leaves, :leave_from, :date
    remove_column :leaves, :leave_to, :date

    add_column :leaves, :leave_from, :datetime
    add_column :leaves, :leave_to, :datetime

  end
end
