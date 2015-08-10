json.array!(@periods) do |period|
  json.extract! period, :id, :time_table_id, :period_num, :subject_id, :day
  json.url period_url(period, format: :json)
end
