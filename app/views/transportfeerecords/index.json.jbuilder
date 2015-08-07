json.array!(@transportfeerecords) do |transportfeerecord|
  json.extract! transportfeerecord, :id, :bus_allotment_id, :fee
  json.url transportfeerecord_url(transportfeerecord, format: :json)
end
