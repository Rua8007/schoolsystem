class CreateHeadings < ActiveRecord::Migration
  def change
    create_table :headings do |t|
      t.string  :label
      t.string  :method
    end
  end
end
