json.array!(@items) do |item|
  json.extract! item, :id, :code, :name, :shopcategory_id, :size, :price, :grade_id, :sold, :left
  json.url item_url(item, format: :json)
end
