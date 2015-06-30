json.array!(@employees) do |employee|
  json.extract! employee, :id, :employee_number, :date_of_joining, :full_name, :gender, :date_of_birth, :religion, :qualification, :employee_category_id, :employee_department_id, :marital_status, :child_count, :father_name, :mother_name, :spouse_name, :blood_group, :nationality, :id_card_no, :id_card_expiry, :address1, :address2, :city, :country, :home_phone, :mobile_number, :email, :salary, :employee_position_id, :status, :pay_date, :next_due_date
  json.url employee_url(employee, format: :json)
end