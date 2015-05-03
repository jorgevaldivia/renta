class Invoice::LineItem < ActiveRecord::Base
  acts_as_tenant :account

  belongs_to :invoice, touch: true

  monetize :amount_cents, allow_nil: true
end
