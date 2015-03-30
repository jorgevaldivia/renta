class Invoice < ActiveRecord::Base
  belongs_to :user
  belongs_to :lease
  has_many :line_items, dependent: :destroy

  monetize :total_amount_cents, allow_nil: true

  after_touch :calculate_total_amount

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
