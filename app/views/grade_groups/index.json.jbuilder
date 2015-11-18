json.array!(@grade_groups) do |grade_group|
  json.extract! grade_group, :id, :name, :grade_id, :integer
  json.url grade_group_url(grade_group, format: :json)
end
