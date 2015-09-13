class CreateCalenders < ActiveRecord::Migration
  def change
    create_table :calenders do |t|
      t.string :title
      t.text :description
      t.datetime :starttime
      t.datetime :endtime

      t.timestamps null: false
    end
  end
end
