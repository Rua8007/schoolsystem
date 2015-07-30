class CreateTransportfeerecords < ActiveRecord::Migration
  def change
    create_table :transportfeerecords do |t|
      t.integer :bus_allotment_id
      t.float :fee

      t.timestamps null: false
    end
  end
end
