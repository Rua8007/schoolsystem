class CreateEmergencies < ActiveRecord::Migration
  def change
    create_table :emergencies do |t|
      t.string :name
      t.string :mobile
      t.string :phone
      t.string :email

      t.timestamps null: false
    end
  end
end
