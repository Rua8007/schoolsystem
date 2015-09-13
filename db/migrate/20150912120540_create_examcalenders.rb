class CreateExamcalenders < ActiveRecord::Migration
  def change
    create_table :examcalenders do |t|
      t.integer :bridge_id
      t.string :title
      t.text :description
      t.string :category
      t.datetime :starttime
      t.datetime :endtime

      t.timestamps null: false
    end
  end
end
