class RemoveVehicleNoIntegerFromVehicles < ActiveRecord::Migration
  def change
  	remove_column :vehicles,	:vehicle_no, :integer
  	add_column :vehicles,	:vehicle_no, :string
  end
end
