class Lease < ActiveRecord::Base
  belongs_to :property

  FREQUENCY_TYPES = %w(days weeks months years).freeze

  validates :start_date, :frequency, :interval, :rent, presence: true
  validates :frequency, inclusion: { in: FREQUENCY_TYPES }
  validates :interval, numericality: { greater_than_or_equal_to: 0 }, if: Proc.new{ |x| x.interval.present? }
  validates :rent, numericality: { greater_than_or_equal_to: 0 }, if: Proc.new{ |x| x.rent.present? }
  validates :deposit, numericality: { greater_than_or_equal_to: 0 }, if: Proc.new{ |x| x.deposit.present? }
  validate :does_not_overlap, if: Proc.new{ |x| x.start_date.present? }
  validate :end_date_after_start_date

  before_save :calculate_next_bill_date

  monetize :rent_cents, allow_nil: true
  monetize :deposit_cents, allow_nil: true

  scope :overlapping_dates, ->(lease) { 
    where("id <> COALESCE(?, 0) AND ((start_date, COALESCE(end_date, 'infinity'::timestamp)) OVERLAPS(?, COALESCE(?, 'infinity'::timestamp)))",
          lease.id, lease.start_date, lease.end_date)
  }

  default_scope { order('start_date desc') } 

  private

  concerning :Billing do
    def calculate_next_bill_date
      if end_date.present? && next_bill_date.present? && end_date <= next_bill_date
        self.next_bill_date = nil
        return
      end

      # It's not yet time to calculate next bill date
      return if next_bill_date.present? && Date.today < next_bill_date

      if next_bill_date.present?
        # Been billed before, always go off that if available
        date = next_bill_date
        # Turns into something like `date + 1.month`
        self.next_bill_date = date.send(:+, eval("#{interval}.#{frequency}"))
      else
        # Never been billed before. Go off of start date.
        if start_date >= Date.today
          self.next_bill_date = start_date
        elsif end_date.blank? || (end_date.present? && end_date >= Date.today)
          # Only calculate leases that haven't ended
          date = start_date
          index = 0
          while(Date.today >= date)
            date = date.send(:+, eval("#{interval}.#{frequency}"))
            index += 1

            # Don't want people entering open leases from a long time ago
            if index >= 500
              date = nil
              break
            end
          end

          self.next_bill_date = date if date
        end
      end
    end
  end

  concerning :Validations do
    # Check to make sure that no date ranges over lap
    def does_not_overlap
      if property.leases.overlapping_dates(self).any?
        self.errors.add(:start_date, :cannot_overlap)
        false
      end
    end

    # Basic end > start validation
    def end_date_after_start_date
      if end_date.present? && start_date.present? && end_date <= start_date
        self.errors.add(:end_date, :end_date_after_start_date)
        false
      end
    end
  end
end
