class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.integer :exam_id
      t.integer :bridge_id

      t.timestamps null: false
    end
  end
end
