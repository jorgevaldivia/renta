json.cache! property do

  json.merge! property.attributes

  json.total_revenue property.total_revenue.try(:amount)
  json.total_expenses property.total_expenses.try(:amount)
  json.total_profit property.total_profit.try(:amount)

  json.current_lease do
    if property.current_lease.present?
      json.partial! '/properties/leases/lease', lease: property.current_lease
    end
  end
end
