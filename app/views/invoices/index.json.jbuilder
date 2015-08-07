json.array!(@invoices) do |invoice|
  json.extract! invoice, :id, :booknum, :student_id, :discount
  json.url invoice_url(invoice, format: :json)
end
