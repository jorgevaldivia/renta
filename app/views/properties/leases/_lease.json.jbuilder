json.cache! lease do

  json.merge! lease.attributes

  json.rent lease.rent.try(:amount)
  json.deposit lease.deposit.try(:amount)
end
