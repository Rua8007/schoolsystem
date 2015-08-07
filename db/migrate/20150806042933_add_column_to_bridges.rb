class AddColumnToBridges < ActiveRecord::Migration
  def change
  	add_column :bridges, :total_days, :integer
  end
end
