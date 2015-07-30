json.array!(@student_holidays) do |student_holiday|
  json.extract! student_holiday, :id, :reason, :description, :student_id, :leave_from, :leave_to, :approved
  json.url student_holiday_url(student_holiday, format: :json)
end
