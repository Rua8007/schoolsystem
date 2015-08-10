class CreatePeriods < ActiveRecord::Migration
  def change
    create_table :periods do |t|
      t.integer :time_table_id
      t.integer :period_num
      t.integer :subject_id
      t.string :day

      t.timestamps null: false
    end
  end
end
