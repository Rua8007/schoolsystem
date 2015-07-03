class RenameColumnsOfEmployees < ActiveRecord::Migration
  def change
  	rename_column :employees, :employee_category_id, :category_id
  	rename_column :employees, :employee_department_id, :department_id
  	rename_column :employees, :employee_position_id, :position_id
  end
end
