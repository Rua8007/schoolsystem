class RemoveDataFromVehicles < ActiveRecord::Migration
  def change
  
	remove_column :vehicles,	:address, :string
	remove_column :vehicles,	:city, :string
	remove_column :vehicles,	:state, :string
	remove_column :vehicles,	:phone, :string
  end
end
