json.array!(@calenders) do |calender|
  json.extract! calender, :id, :title, :description
  json.start calender.starttime
  json.end calender.endtime
  json.url calender_url(calender, format: :html)
end