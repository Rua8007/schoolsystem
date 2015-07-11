class AddColumnToLeaves < ActiveRecord::Migration
  def change
    add_column :leaves, :approved, :boolean, :default => false
  end
end
