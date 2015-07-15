json.array!(@bridges) do |bridge|
  json.extract! bridge, :id, :subject_id, :grade_id, :employee_id
  json.url bridge_url(bridge, format: :json)
end
