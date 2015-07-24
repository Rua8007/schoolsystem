require 'test_helper'

class StudentHolidaysControllerTest < ActionController::TestCase
  setup do
    @student_holiday = student_holidays(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:student_holidays)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create student_holiday" do
    assert_difference('StudentHoliday.count') do
      post :create, student_holiday: { approved: @student_holiday.approved, description: @student_holiday.description, leave_from: @student_holiday.leave_from, leave_to: @student_holiday.leave_to, reason: @student_holiday.reason, student_id: @student_holiday.student_id }
    end

    assert_redirected_to student_holiday_path(assigns(:student_holiday))
  end

  test "should show student_holiday" do
    get :show, id: @student_holiday
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @student_holiday
    assert_response :success
  end

  test "should update student_holiday" do
    patch :update, id: @student_holiday, student_holiday: { approved: @student_holiday.approved, description: @student_holiday.description, leave_from: @student_holiday.leave_from, leave_to: @student_holiday.leave_to, reason: @student_holiday.reason, student_id: @student_holiday.student_id }
    assert_redirected_to student_holiday_path(assigns(:student_holiday))
  end

  test "should destroy student_holiday" do
    assert_difference('StudentHoliday.count', -1) do
      delete :destroy, id: @student_holiday
    end

    assert_redirected_to student_holidays_path
  end
end
