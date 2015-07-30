class AddExperienceToEmployees < ActiveRecord::Migration
  def change
  	add_column :employees, :total_experience_years, :integer
  	add_column :employees, :total_experience_months, :integer
  end
end
