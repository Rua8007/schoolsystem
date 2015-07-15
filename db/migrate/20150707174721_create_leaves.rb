class CreateLeaves < ActiveRecord::Migration
  def change
    create_table :leaves do |t|
      t.string :reason
      t.text :description
      t.integer :employee_id
      t.date :leave_from
      t.date :leave_to

      t.timestamps null: false
    end
  end
end
