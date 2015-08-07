json.array!(@weeks) do |week|
  json.extract! week, :id, :year_plan_id, :start_date, :end_date, :holiday_description, :year_week_id
  json.url week_url(week, format: :json)
end
