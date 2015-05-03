class Invoice < ActiveRecord::Base
  # Statuses: open, due, overdue, paid

  belongs_to :user
  belongs_to :lease
  has_many :line_items, dependent: :destroy

  monetize :total_amount_cents, allow_nil: true

  after_touch :calculate_total_amount

  scope :due, -> { where("issue_date <= ? and due_date >= ? and status != 'paid'", Date.today, Date.today) }
  scope :overdue, -> { where("due_date <= ? and status != 'paid'", Date.today) }

  private

  # Calculates the total amount from the line items
  def calculate_total_amount
    self.total_amount = 0
    
    self.line_items.each do |line_item|
      self.total_amount += (line_item.amount || 0)
    end

    self.save
  end
end
