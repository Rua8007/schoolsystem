class CreateSessionals < ActiveRecord::Migration
  def change
    create_table :sessionals do |t|
      t.integer :marksheet_id
      t.integer :mark_id
      t.float :marks

      t.timestamps null: false
    end
  end
end
