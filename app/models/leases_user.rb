class LeasesUser < ActiveRecord::Base
  acts_as_tenant :account

  belongs_to :lease
  belongs_to :contact

  default_scope { order("#{table_name}.created_at asc") } 
end
