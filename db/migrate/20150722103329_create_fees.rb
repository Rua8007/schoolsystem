class CreateFees < ActiveRecord::Migration
  def change
    create_table :fees do |t|
      t.integer :student_id
      t.integer :amount
      t.integer :user_id
      t.string :month

      t.timestamps null: false
    end
  end
end
