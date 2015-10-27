class AddBadColsToPerformances < ActiveRecord::Migration
  def change
    add_column :performances, :les, :boolean
  end
end
