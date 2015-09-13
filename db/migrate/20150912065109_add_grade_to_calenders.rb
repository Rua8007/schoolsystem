class AddGradeToCalenders < ActiveRecord::Migration
  def change
    add_column :calenders, :grade, :string
  end
end
