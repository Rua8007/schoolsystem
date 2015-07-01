require 'test_helper'

class EmployeesControllerTest < ActionController::TestCase
  setup do
    @employee = employees(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:employees)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create employee" do
    assert_difference('Employee.count') do
      post :create, employee: { address1: @employee.address1, address2: @employee.address2, blood_group: @employee.blood_group, child_count: @employee.child_count, city: @employee.city, country: @employee.country, date_of_birth: @employee.date_of_birth, date_of_joining: @employee.date_of_joining, email: @employee.email, employee_category_id: @employee.employee_category_id, employee_department_id: @employee.employee_department_id, employee_number: @employee.employee_number, employee_position_id: @employee.employee_position_id, father_name: @employee.father_name, full_name: @employee.full_name, gender: @employee.gender, home_phone: @employee.home_phone, id_card_expiry: @employee.id_card_expiry, id_card_no: @employee.id_card_no, marital_status: @employee.marital_status, mobile_number: @employee.mobile_number, mother_name: @employee.mother_name, nationality: @employee.nationality, next_due_date: @employee.next_due_date, pay_date: @employee.pay_date, qualification: @employee.qualification, religion: @employee.religion, salary: @employee.salary, spouse_name: @employee.spouse_name, status: @employee.status }
    end

    assert_redirected_to employee_path(assigns(:employee))
  end

  test "should show employee" do
    get :show, id: @employee
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @employee
    assert_response :success
  end

  test "should update employee" do
    patch :update, id: @employee, employee: { address1: @employee.address1, address2: @employee.address2, blood_group: @employee.blood_group, child_count: @employee.child_count, city: @employee.city, country: @employee.country, date_of_birth: @employee.date_of_birth, date_of_joining: @employee.date_of_joining, email: @employee.email, employee_category_id: @employee.employee_category_id, employee_department_id: @employee.employee_department_id, employee_number: @employee.employee_number, employee_position_id: @employee.employee_position_id, father_name: @employee.father_name, full_name: @employee.full_name, gender: @employee.gender, home_phone: @employee.home_phone, id_card_expiry: @employee.id_card_expiry, id_card_no: @employee.id_card_no, marital_status: @employee.marital_status, mobile_number: @employee.mobile_number, mother_name: @employee.mother_name, nationality: @employee.nationality, next_due_date: @employee.next_due_date, pay_date: @employee.pay_date, qualification: @employee.qualification, religion: @employee.religion, salary: @employee.salary, spouse_name: @employee.spouse_name, status: @employee.status }
    assert_redirected_to employee_path(assigns(:employee))
  end

  test "should destroy employee" do
    assert_difference('Employee.count', -1) do
      delete :destroy, id: @employee
    end

    assert_redirected_to employees_path
  end
end
