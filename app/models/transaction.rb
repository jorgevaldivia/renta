class Transaction < ActiveRecord::Base
  acts_as_tenant :account

  belongs_to :user
  belongs_to :item, polymorphic:true

  TRANSACTION_TYPES = %w(income expense).freeze

  validates :amount, :user, :item, :transaction_type, presence: true

  monetize :amount_cents, allow_nil: true
end
