# Updates the current lease once it has expired. 
class LeaseService::CurrentLeaseUpdater
  def initialize
  end

  def perform
    Property.with_expired_lease.find_each do |property|
      property.current_lease_id = property.leases.current.try(:id)
      property.save
    end
  end
end