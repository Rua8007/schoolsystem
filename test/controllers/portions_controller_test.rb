require 'test_helper'

class PortionsControllerTest < ActionController::TestCase
  setup do
    @portion = portions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:portions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create portion" do
    assert_difference('Portion.count') do
      post :create, portion: { quarter: @portion.quarter, year_plan_id: @portion.year_plan_id }
    end

    assert_redirected_to portion_path(assigns(:portion))
  end

  test "should show portion" do
    get :show, id: @portion
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @portion
    assert_response :success
  end

  test "should update portion" do
    patch :update, id: @portion, portion: { quarter: @portion.quarter, year_plan_id: @portion.year_plan_id }
    assert_redirected_to portion_path(assigns(:portion))
  end

  test "should destroy portion" do
    assert_difference('Portion.count', -1) do
      delete :destroy, id: @portion
    end

    assert_redirected_to portions_path
  end
end
