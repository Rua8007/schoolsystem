json.array!(@bus_allotments) do |bus_allotment|
  json.extract! bus_allotment, :id, :student_id, :transport_id, :route_id, :stop_id
  json.url bus_allotment_url(bus_allotment, format: :json)
end
