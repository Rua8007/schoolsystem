json.array!(@vehicles) do |vehicle|
  json.extract! vehicle, :id, :vehicle_no, :code, :seat, :max_allowed, :vehicle_type, :address, :city, :state, :phone, :insurance, :tax, :permit
  json.url vehicle_url(vehicle, format: :json)
end
