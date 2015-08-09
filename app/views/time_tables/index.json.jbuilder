json.array!(@time_tables) do |time_table|
  json.extract! time_table, :id, :grade_id, :employee_id, :break_after_period, :prayer_after_period
  json.url time_table_url(time_table, format: :json)
end
