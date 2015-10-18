class AddColsToPerformace < ActiveRecord::Migration
  def change
    add_column :performances, :lc, :boolean
    add_column :performances, :fa, :boolean
    add_column :performances, :pw, :boolean
    add_column :performances, :lk, :boolean
    add_column :performances, :ia, :boolean
    add_column :performances, :pc, :boolean
  end
end
