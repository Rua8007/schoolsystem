class CreateBusAllotments < ActiveRecord::Migration
  def change
    create_table :bus_allotments do |t|
      t.integer :student_id
      t.integer :transport_id
      t.integer :route_id
      t.integer :stop_id

      t.timestamps null: false
    end
  end
end
