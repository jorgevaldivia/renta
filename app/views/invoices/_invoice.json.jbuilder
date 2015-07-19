json.cache! invoice do
  json.merge! invoice.attributes

  json.total_amount invoice.total_amount.try(:amount)

  json.tenants do
    json.partial! '/contacts/contact', collection: invoice.lease.tenants, as: :contact
  end

  json.line_items do
    json.partial! '/invoices/line_items/line_item', collection: invoice.line_items, as: :line_item
  end
end
