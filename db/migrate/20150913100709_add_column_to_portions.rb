class AddColumnToPortions < ActiveRecord::Migration
  def change
    add_column :portions, :grade_id, :integer
  end
end
