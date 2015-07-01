class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :employee_number
      t.date :date_of_joining
      t.string :full_name
      t.string :gender
      t.date :date_of_birth
      t.string :religion
      t.string :qualification
      t.integer :employee_category_id
      t.integer :employee_department_id
      t.string :marital_status
      t.integer :child_count
      t.string :father_name
      t.string :mother_name
      t.string :spouse_name
      t.string :blood_group
      t.string :nationality
      t.string :id_card_no
      t.date :id_card_expiry
      t.string :address1
      t.string :address2
      t.string :city
      t.string :country
      t.string :home_phone
      t.string :mobile_number
      t.string :email
      t.float :salary
      t.integer :employee_position_id
      t.string :status
      t.date :pay_date
      t.date :next_due_date

      t.timestamps null: false
    end
  end
end
