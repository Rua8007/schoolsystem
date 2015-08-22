json.array!(@portions) do |portion|
  json.extract! portion, :id, :year_plan_id, :quarter
  json.url portion_url(portion, format: :json)
end
