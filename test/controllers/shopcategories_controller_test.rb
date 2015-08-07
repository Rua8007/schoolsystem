require 'test_helper'

class ShopcategoriesControllerTest < ActionController::TestCase
  setup do
    @shopcategory = shopcategories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:shopcategories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create shopcategory" do
    assert_difference('Shopcategory.count') do
      post :create, shopcategory: { name: @shopcategory.name }
    end

    assert_redirected_to shopcategory_path(assigns(:shopcategory))
  end

  test "should show shopcategory" do
    get :show, id: @shopcategory
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @shopcategory
    assert_response :success
  end

  test "should update shopcategory" do
    patch :update, id: @shopcategory, shopcategory: { name: @shopcategory.name }
    assert_redirected_to shopcategory_path(assigns(:shopcategory))
  end

  test "should destroy shopcategory" do
    assert_difference('Shopcategory.count', -1) do
      delete :destroy, id: @shopcategory
    end

    assert_redirected_to shopcategories_path
  end
end
