require 'test_helper'

class GradeGroupsControllerTest < ActionController::TestCase
  setup do
    @grade_group = grade_groups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:grade_groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create grade_group" do
    assert_difference('GradeGroup.count') do
      post :create, grade_group: { name: @grade_group.name }
    end

    assert_redirected_to grade_group_path(assigns(:grade_group))
  end

  test "should show grade_group" do
    get :show, id: @grade_group
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @grade_group
    assert_response :success
  end

  test "should update grade_group" do
    patch :update, id: @grade_group, grade_group: { name: @grade_group.name }
    assert_redirected_to grade_group_path(assigns(:grade_group))
  end

  test "should destroy grade_group" do
    assert_difference('GradeGroup.count', -1) do
      delete :destroy, id: @grade_group
    end

    assert_redirected_to grade_groups_path
  end
end
