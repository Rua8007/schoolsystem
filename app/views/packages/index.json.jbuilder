json.array!(@packages) do |package|
  json.extract! package, :id, :name, :code, :price, :sold
  json.url package_url(package, format: :json)
end
