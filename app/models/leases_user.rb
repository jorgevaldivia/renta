class LeasesUser < ActiveRecord::Base
  acts_as_tenant :account

  belongs_to :lease
  belongs_to :user
end
