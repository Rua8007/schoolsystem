class AddGoodColsToPerformances < ActiveRecord::Migration
  def change
    add_column :performances, :tal, :boolean
    add_column :performances, :sd, :boolean
    add_column :performances, :res, :boolean
    add_column :performances, :fail, :boolean
    add_column :performances, :art, :boolean
  end
end
