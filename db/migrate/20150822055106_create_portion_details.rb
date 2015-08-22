class CreatePortionDetails < ActiveRecord::Migration
  def change
    create_table :portion_details do |t|
      t.integer :portion_id
      t.integer :subject_id
      t.text :note

      t.timestamps null: false
    end
  end
end
