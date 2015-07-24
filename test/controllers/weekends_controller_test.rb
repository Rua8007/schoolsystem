require 'test_helper'

class WeekendsControllerTest < ActionController::TestCase
  setup do
    @weekend = weekends(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:weekends)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create weekend" do
    assert_difference('Weekend.count') do
      post :create, weekend: { weekend_day: @weekend.weekend_day }
    end

    assert_redirected_to weekend_path(assigns(:weekend))
  end

  test "should show weekend" do
    get :show, id: @weekend
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @weekend
    assert_response :success
  end

  test "should update weekend" do
    patch :update, id: @weekend, weekend: { weekend_day: @weekend.weekend_day }
    assert_redirected_to weekend_path(assigns(:weekend))
  end

  test "should destroy weekend" do
    assert_difference('Weekend.count', -1) do
      delete :destroy, id: @weekend
    end

    assert_redirected_to weekends_path
  end
end
