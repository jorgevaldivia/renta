class Transaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :item, polymorphic:true

  TRANSACTION_TYPES = %w(income expense).freeze

  validates :amount, :user, :item, :transaction_type, presence: true

  monetize :amount_cents, allow_nil: true
end
