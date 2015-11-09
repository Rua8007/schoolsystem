class AddColumnsToSubject < ActiveRecord::Migration
  def change
    add_column :subjects, :parent_id, :integer
    add_column :subjects, :weight, :float
  end
end
