class AddSpecialneedToStudents < ActiveRecord::Migration
  def change
    add_column :students, :specialneed, :string
  end
end
