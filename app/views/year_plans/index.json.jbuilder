json.array!(@year_plans) do |year_plan|
  json.extract! year_plan, :id, :year_name
  json.url year_plan_url(year_plan, format: :json)
end
