require 'test_helper'

class BridgesControllerTest < ActionController::TestCase
  setup do
    @bridge = bridges(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bridges)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bridge" do
    assert_difference('Bridge.count') do
      post :create, bridge: { employee_id: @bridge.employee_id, grade_id: @bridge.grade_id, subject_id: @bridge.subject_id }
    end

    assert_redirected_to bridge_path(assigns(:bridge))
  end

  test "should show bridge" do
    get :show, id: @bridge
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bridge
    assert_response :success
  end

  test "should update bridge" do
    patch :update, id: @bridge, bridge: { employee_id: @bridge.employee_id, grade_id: @bridge.grade_id, subject_id: @bridge.subject_id }
    assert_redirected_to bridge_path(assigns(:bridge))
  end

  test "should destroy bridge" do
    assert_difference('Bridge.count', -1) do
      delete :destroy, id: @bridge
    end

    assert_redirected_to bridges_path
  end
end
