class CreateExams < ActiveRecord::Migration
  def change
    create_table :exams do |t|
      t.string :name
      t.integer :batch_id

      t.timestamps null: false
    end
  end
end
