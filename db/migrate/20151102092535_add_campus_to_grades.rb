class AddCampusToGrades < ActiveRecord::Migration
  def change
    add_column :grades, :campus, :string
  end
end
