class CreateFeebreakdowns < ActiveRecord::Migration
  def change
    create_table :feebreakdowns do |t|
      t.integer :grade_id
      t.string :title
      t.integer :amount

      t.timestamps null: false
    end
  end
end
