json.array!(@departments) do |department|
  json.extract! department, :id, :code, :name
  json.url department_url(department, format: :json)
end
