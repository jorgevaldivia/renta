class LeasesUser < ActiveRecord::Base
  belongs_to :lease
  belongs_to :user
end
