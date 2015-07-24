json.array!(@weekends) do |weekend|
  json.extract! weekend, :id, :weekend_day
  json.url weekend_url(weekend, format: :json)
end
