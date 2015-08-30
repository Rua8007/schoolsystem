class CreateAddResultToMarksheets < ActiveRecord::Migration
  def change
    create_table :add_result_to_marksheets do |t|
      t.integer :result_id

      t.timestamps null: false
    end
  end
end
