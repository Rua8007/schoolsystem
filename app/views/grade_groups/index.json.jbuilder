json.array!(@grade_groups) do |grade_group|
  json.extract! grade_group, :id, :name
  json.url grade_group_url(grade_group, format: :json)
end
