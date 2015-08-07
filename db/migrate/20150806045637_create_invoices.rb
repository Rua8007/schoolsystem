class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.string :booknum
      t.integer :student_id
      t.float :discount

      t.timestamps null: false
    end
  end
end
