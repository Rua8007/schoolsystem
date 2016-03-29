class CreateFeeModes < ActiveRecord::Migration
  def change
    create_table :fee_modes do |t|
      t.string :name
      t.integer :no_of_payments

      t.timestamps null: false
    end

    FeeMode.find_or_create_by(name: 'Annually',            no_of_payments: 1)
    FeeMode.find_or_create_by(name: 'Bi Annually',         no_of_payments: 2)
    FeeMode.find_or_create_by(name: 'Quarterly',           no_of_payments: 4)
    FeeMode.find_or_create_by(name: 'Every 4 Months',      no_of_payments: 3)
  end
end
