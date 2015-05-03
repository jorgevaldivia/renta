class Property < ActiveRecord::Base
  belongs_to :user
  has_many :leases
  has_many :invoices, through: :leases
  belongs_to :current_lease, class_name: "Lease", foreign_key: :current_lease_id

  validates :name, :address_line_1, :city, :state, :postal_code, presence: true

  monetize :total_revenue_cents, allow_nil: true
  monetize :total_expenses_cents, allow_nil: true
  monetize :total_profit_cents, allow_nil: true

  before_save :calculate_total_proft

  default_scope { order('name asc') }

  scope :with_expired_lease, -> { where("leases.end_date < current_date").joins(:current_lease) }

  def full_address
    [address_line_1, address_line_2, city, state, postal_code].compact.join(" ")
  end

  private

  def calculate_total_proft
    if total_revenue && total_expenses
      self.total_profit = total_revenue - total_expenses
    else
      self.total_profit = self.total_revenue = self.total_expenses = 0
    end
  end
end
