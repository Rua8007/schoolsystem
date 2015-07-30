require 'test_helper'

class TransportfeerecordsControllerTest < ActionController::TestCase
  setup do
    @transportfeerecord = transportfeerecords(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:transportfeerecords)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create transportfeerecord" do
    assert_difference('Transportfeerecord.count') do
      post :create, transportfeerecord: { bus_allotment_id: @transportfeerecord.bus_allotment_id, fee: @transportfeerecord.fee }
    end

    assert_redirected_to transportfeerecord_path(assigns(:transportfeerecord))
  end

  test "should show transportfeerecord" do
    get :show, id: @transportfeerecord
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @transportfeerecord
    assert_response :success
  end

  test "should update transportfeerecord" do
    patch :update, id: @transportfeerecord, transportfeerecord: { bus_allotment_id: @transportfeerecord.bus_allotment_id, fee: @transportfeerecord.fee }
    assert_redirected_to transportfeerecord_path(assigns(:transportfeerecord))
  end

  test "should destroy transportfeerecord" do
    assert_difference('Transportfeerecord.count', -1) do
      delete :destroy, id: @transportfeerecord
    end

    assert_redirected_to transportfeerecords_path
  end
end
