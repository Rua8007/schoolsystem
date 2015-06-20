class AddColumnsToStudent < ActiveRecord::Migration
  def change
    add_column :students, :first_name, :string
    add_column :students, :middle_name, :string
    add_column :students, :last_name, :string
    add_column :students, :grade_id, :integer
    add_column :students, :gender, :string
    add_column :students, :dob, :string
    add_column :students, :blood, :string
    add_column :students, :birth_place, :string
    add_column :students, :nationality, :string
    add_column :students, :language, :string
    add_column :students, :religion, :string
    add_column :students, :address, :string
    add_column :students, :city, :string
    add_column :students, :state, :string
    add_column :students, :pincode, :string
    add_column :students, :country, :string
    add_column :students, :mobile, :string
    add_column :students, :phone, :string
    add_column :students, :email, :string
    add_column :students, :parent_id, :string
  end
end
