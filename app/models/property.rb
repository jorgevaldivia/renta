class Property < ActiveRecord::Base
  belongs_to :user
  has_many :leases
  belongs_to :current_lease, class_name: "Lease", foreign_key: :current_lease_id

  validates :name, :address_line_1, :city, :state, :postal_code, presence: true

  monetize :total_revenue_cents, allow_nil: true
  monetize :total_expenses_cents, allow_nil: true
  monetize :total_profit_cents, allow_nil: true

  before_save :calculate_total_proft

  default_scope { order('name asc') } 

  private

  def calculate_total_proft
    self.total_profit = total_revenue - total_expenses
  end
end
