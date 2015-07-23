require 'test_helper'

class VehiclesControllerTest < ActionController::TestCase
  setup do
    @vehicle = vehicles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:vehicles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vehicle" do
    assert_difference('Vehicle.count') do
      post :create, vehicle: { address: @vehicle.address, city: @vehicle.city, code: @vehicle.code, insurance: @vehicle.insurance, max_allowed: @vehicle.max_allowed, permit: @vehicle.permit, phone: @vehicle.phone, seat: @vehicle.seat, state: @vehicle.state, tax: @vehicle.tax, vehicle_no: @vehicle.vehicle_no, vehicle_type: @vehicle.vehicle_type }
    end

    assert_redirected_to vehicle_path(assigns(:vehicle))
  end

  test "should show vehicle" do
    get :show, id: @vehicle
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @vehicle
    assert_response :success
  end

  test "should update vehicle" do
    patch :update, id: @vehicle, vehicle: { address: @vehicle.address, city: @vehicle.city, code: @vehicle.code, insurance: @vehicle.insurance, max_allowed: @vehicle.max_allowed, permit: @vehicle.permit, phone: @vehicle.phone, seat: @vehicle.seat, state: @vehicle.state, tax: @vehicle.tax, vehicle_no: @vehicle.vehicle_no, vehicle_type: @vehicle.vehicle_type }
    assert_redirected_to vehicle_path(assigns(:vehicle))
  end

  test "should destroy vehicle" do
    assert_difference('Vehicle.count', -1) do
      delete :destroy, id: @vehicle
    end

    assert_redirected_to vehicles_path
  end
end
