class AddFeeFromBusAllotments < ActiveRecord::Migration
  def change
    add_column :bus_allotments, :fee, :float
  end
end
