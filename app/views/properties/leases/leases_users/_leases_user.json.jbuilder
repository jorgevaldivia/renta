json.cache! leases_user do
  json.merge! leases_user.attributes

  json.contact do
    if leases_user.contact.present?
      json.partial! '/contacts/contact', contact: leases_user.contact
    end
  end
end