require 'test_helper'

class BusAllotmentsControllerTest < ActionController::TestCase
  setup do
    @bus_allotment = bus_allotments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bus_allotments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bus_allotment" do
    assert_difference('BusAllotment.count') do
      post :create, bus_allotment: { route_id: @bus_allotment.route_id, stop_id: @bus_allotment.stop_id, student_id: @bus_allotment.student_id, transport_id: @bus_allotment.transport_id }
    end

    assert_redirected_to bus_allotment_path(assigns(:bus_allotment))
  end

  test "should show bus_allotment" do
    get :show, id: @bus_allotment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bus_allotment
    assert_response :success
  end

  test "should update bus_allotment" do
    patch :update, id: @bus_allotment, bus_allotment: { route_id: @bus_allotment.route_id, stop_id: @bus_allotment.stop_id, student_id: @bus_allotment.student_id, transport_id: @bus_allotment.transport_id }
    assert_redirected_to bus_allotment_path(assigns(:bus_allotment))
  end

  test "should destroy bus_allotment" do
    assert_difference('BusAllotment.count', -1) do
      delete :destroy, id: @bus_allotment
    end

    assert_redirected_to bus_allotments_path
  end
end
