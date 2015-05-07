json.cache! lease do

  json.merge! lease.attributes

  json.rent lease.rent.try(:amount)
  json.deposit lease.deposit.try(:amount)
  json.ending_soon lease.ending_soon?

  json.leases_users do
    json.partial! '/properties/leases/leases_users/leases_user', collection: lease.leases_users, as: :leases_user
  end

  json.next_invoice do
    if lease.next_invoice.present?
      json.partial! '/invoices/invoice', invoice: lease.next_invoice
    end
  end
end
