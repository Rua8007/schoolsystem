class CreateTransports < ActiveRecord::Migration
  def change
    create_table :transports do |t|
      t.string :arrival
      t.string :departure
      t.integer :employee_id
      t.integer :route_id
      t.integer :vehicle_id

      t.timestamps null: false
    end
  end
end
