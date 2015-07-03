require 'test_helper'

class ParentsControllerTest < ActionController::TestCase
  setup do
    @parent = parents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:parents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create parent" do
    assert_difference('Parent.count') do
      post :create, parent: { address1: @parent.address1, address2: @parent.address2, city: @parent.city, country: @parent.country, dob: @parent.dob, education: @parent.education, email: @parent.email, income: @parent.income, iqamaExpiry: @parent.iqamaExpiry, iqamaNumber: @parent.iqamaNumber, mobile: @parent.mobile, name: @parent.name, officePhone: @parent.officePhone, profession: @parent.profession, relation: @parent.relation }
    end

    assert_redirected_to parent_path(assigns(:parent))
  end

  test "should show parent" do
    get :show, id: @parent
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @parent
    assert_response :success
  end

  test "should update parent" do
    patch :update, id: @parent, parent: { address1: @parent.address1, address2: @parent.address2, city: @parent.city, country: @parent.country, dob: @parent.dob, education: @parent.education, email: @parent.email, income: @parent.income, iqamaExpiry: @parent.iqamaExpiry, iqamaNumber: @parent.iqamaNumber, mobile: @parent.mobile, name: @parent.name, officePhone: @parent.officePhone, profession: @parent.profession, relation: @parent.relation }
    assert_redirected_to parent_path(assigns(:parent))
  end

  test "should destroy parent" do
    assert_difference('Parent.count', -1) do
      delete :destroy, id: @parent
    end

    assert_redirected_to parents_path
  end
end
