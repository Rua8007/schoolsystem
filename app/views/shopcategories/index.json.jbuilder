json.array!(@shopcategories) do |shopcategory|
  json.extract! shopcategory, :id, :name
  json.url shopcategory_url(shopcategory, format: :json)
end
