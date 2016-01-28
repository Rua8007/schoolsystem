class AddSecEmailToStudents < ActiveRecord::Migration
  def change
    add_column :students, :secondary_email, :string
  end
end
