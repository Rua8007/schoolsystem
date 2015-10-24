class AddCollsToPerformance < ActiveRecord::Migration
  def change
    add_column :performances, :good, :boolean
    add_column :performances, :vg, :boolean
    add_column :performances, :st, :boolean
    add_column :performances, :exc, :boolean
  end
end
