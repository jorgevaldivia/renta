class Invoice::LineItem < ActiveRecord::Base
  belongs_to :invoice, touch: true

  monetize :amount_cents, allow_nil: true
end
