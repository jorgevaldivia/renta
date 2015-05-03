namespace :leases do

  desc 'Updates all current leases.'
  task update_current_leases: :environment do
    LeaseService::CurrentLeaseUpdater.new.perform
  end
end
