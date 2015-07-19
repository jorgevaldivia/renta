json.cache! line_item do
  json.merge! line_item.attributes

  json.amount line_item.amount.try(:amount)
end