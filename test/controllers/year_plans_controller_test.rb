require 'test_helper'

class YearPlansControllerTest < ActionController::TestCase
  setup do
    @year_plan = year_plans(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:year_plans)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create year_plan" do
    assert_difference('YearPlan.count') do
      post :create, year_plan: { year_name: @year_plan.year_name }
    end

    assert_redirected_to year_plan_path(assigns(:year_plan))
  end

  test "should show year_plan" do
    get :show, id: @year_plan
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @year_plan
    assert_response :success
  end

  test "should update year_plan" do
    patch :update, id: @year_plan, year_plan: { year_name: @year_plan.year_name }
    assert_redirected_to year_plan_path(assigns(:year_plan))
  end

  test "should destroy year_plan" do
    assert_difference('YearPlan.count', -1) do
      delete :destroy, id: @year_plan
    end

    assert_redirected_to year_plans_path
  end
end
