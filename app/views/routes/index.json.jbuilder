json.array!(@routes) do |route|
  json.extract! route, :id, :name, :no_of_stop
  json.url route_url(route, format: :json)
end
