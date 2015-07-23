json.array!(@transports) do |transport|
  json.extract! transport, :id, :arrival, :departure, :employee_id, :route_id, :vehicle_id
  json.url transport_url(transport, format: :json)
end
