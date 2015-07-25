require 'test_helper'

class MarksheetsControllerTest < ActionController::TestCase
  setup do
    @marksheet = marksheets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:marksheets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create marksheet" do
    assert_difference('Marksheet.count') do
      post :create, marksheet: { bridge_id: @marksheet.bridge_id, exam_id: @marksheet.exam_id, obtainedmarks: @marksheet.obtainedmarks, student_id: @marksheet.student_id, totalmarks: @marksheet.totalmarks }
    end

    assert_redirected_to marksheet_path(assigns(:marksheet))
  end

  test "should show marksheet" do
    get :show, id: @marksheet
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @marksheet
    assert_response :success
  end

  test "should update marksheet" do
    patch :update, id: @marksheet, marksheet: { bridge_id: @marksheet.bridge_id, exam_id: @marksheet.exam_id, obtainedmarks: @marksheet.obtainedmarks, student_id: @marksheet.student_id, totalmarks: @marksheet.totalmarks }
    assert_redirected_to marksheet_path(assigns(:marksheet))
  end

  test "should destroy marksheet" do
    assert_difference('Marksheet.count', -1) do
      delete :destroy, id: @marksheet
    end

    assert_redirected_to marksheets_path
  end
end
