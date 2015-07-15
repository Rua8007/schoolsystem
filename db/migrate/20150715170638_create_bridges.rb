class CreateBridges < ActiveRecord::Migration
  def change
    create_table :bridges do |t|
      t.integer :subject_id
      t.integer :grade_id
      t.integer :employee_id

      t.timestamps null: false
    end
  end
end
