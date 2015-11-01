class CreateAssociations < ActiveRecord::Migration
  def change
    create_table :associations do |t|
      t.integer :grade_id
      t.integer :subject_id

      t.timestamps null: false
    end
  end
end
