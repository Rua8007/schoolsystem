json.array!(@categories) do |category|
  json.extract! category, :id, :name, :prefix
  json.url category_url(category, format: :json)
end
