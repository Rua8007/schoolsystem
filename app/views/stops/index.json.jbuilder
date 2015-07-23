json.array!(@stops) do |stop|
  json.extract! stop, :id, :name, :route_id
  json.url stop_url(stop, format: :json)
end
