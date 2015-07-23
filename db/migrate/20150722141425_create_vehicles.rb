class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|
      t.integer :vehicle_no
      t.string :code
      t.string :seat
      t.string :max_allowed
      t.string :vehicle_type
      t.string :address
      t.string :city
      t.string :state
      t.string :phone
      t.string :insurance
      t.string :tax
      t.string :permit

      t.timestamps null: false
    end
  end
end
