require 'test_helper'

class FeebreakdownsControllerTest < ActionController::TestCase
  setup do
    @feebreakdown = feebreakdowns(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:feebreakdowns)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create feebreakdown" do
    assert_difference('Feebreakdown.count') do
      post :create, feebreakdown: { amount: @feebreakdown.amount, grade_id: @feebreakdown.grade_id, title: @feebreakdown.title }
    end

    assert_redirected_to feebreakdown_path(assigns(:feebreakdown))
  end

  test "should show feebreakdown" do
    get :show, id: @feebreakdown
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @feebreakdown
    assert_response :success
  end

  test "should update feebreakdown" do
    patch :update, id: @feebreakdown, feebreakdown: { amount: @feebreakdown.amount, grade_id: @feebreakdown.grade_id, title: @feebreakdown.title }
    assert_redirected_to feebreakdown_path(assigns(:feebreakdown))
  end

  test "should destroy feebreakdown" do
    assert_difference('Feebreakdown.count', -1) do
      delete :destroy, id: @feebreakdown
    end

    assert_redirected_to feebreakdowns_path
  end
end
