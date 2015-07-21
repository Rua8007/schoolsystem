json.array!(@grades) do |grade|
  json.extract! grade, :id, :name, :section, :batch_id
  json.url grade_url(grade, format: :json)
end
