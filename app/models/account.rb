class Account < ActiveRecord::Base
  has_many :account_memberships
  has_many :collaborators, through: :account_memberships, source: :user
end
