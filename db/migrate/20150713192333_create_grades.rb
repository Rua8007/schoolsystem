class CreateGrades < ActiveRecord::Migration
  def change
    create_table :grades do |t|
      t.string :name
      t.string :section
      t.integer :batch_id

      t.timestamps null: false
    end
  end
end
