class CreateDues < ActiveRecord::Migration
  def change
    create_table :dues do |t|
      t.references :feeable, polymorphic: true
      t.integer :mode_id
      t.float :total
      t.float :paid
      t.float :balance
      t.float :discount
      t.integer :student_id
      t.integer :grade_id

      t.timestamps null: false
    end
  end
end
