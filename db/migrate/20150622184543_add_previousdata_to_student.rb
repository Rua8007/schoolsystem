class AddPreviousdataToStudent < ActiveRecord::Migration
  def change
    add_column :students, :previousInstitute, :string
    add_column :students, :year, :string
    add_column :students, :totalMarks, :string
    add_column :students, :obtainedMarks, :string
  end
end
