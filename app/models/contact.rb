class Contact < ActiveRecord::Base
  acts_as_tenant :account

  belongs_to :account
  belongs_to :user
  has_many :leases_users, dependent: :destroy
  has_many :leases, through: :leases_users

  validates :email, :name, presence: true
end
