class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.integer :student_id
      t.string :description
      t.string :attachment

      t.timestamps null: false
    end
  end
end
