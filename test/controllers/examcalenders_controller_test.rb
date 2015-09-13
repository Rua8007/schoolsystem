require 'test_helper'

class ExamcalendersControllerTest < ActionController::TestCase
  setup do
    @examcalender = examcalenders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:examcalenders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create examcalender" do
    assert_difference('Examcalender.count') do
      post :create, examcalender: { bridge_id: @examcalender.bridge_id, category: @examcalender.category, description: @examcalender.description, endtime: @examcalender.endtime, starttime: @examcalender.starttime, title: @examcalender.title }
    end

    assert_redirected_to examcalender_path(assigns(:examcalender))
  end

  test "should show examcalender" do
    get :show, id: @examcalender
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @examcalender
    assert_response :success
  end

  test "should update examcalender" do
    patch :update, id: @examcalender, examcalender: { bridge_id: @examcalender.bridge_id, category: @examcalender.category, description: @examcalender.description, endtime: @examcalender.endtime, starttime: @examcalender.starttime, title: @examcalender.title }
    assert_redirected_to examcalender_path(assigns(:examcalender))
  end

  test "should destroy examcalender" do
    assert_difference('Examcalender.count', -1) do
      delete :destroy, id: @examcalender
    end

    assert_redirected_to examcalenders_path
  end
end
