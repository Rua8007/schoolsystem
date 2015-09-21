class AddRollnumberToStudent < ActiveRecord::Migration
  def change
    add_column :students, :rollnumber, :string
  end
end
