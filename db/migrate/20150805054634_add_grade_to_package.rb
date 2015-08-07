class AddGradeToPackage < ActiveRecord::Migration
  def change
    add_column :packages, :grade_id, :integer
  end
end
