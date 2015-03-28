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

  monetize :rent_cents, allow_nil: true
  monetize :deposit_cents, allow_nil: true

  scope :overlapping_dates, ->(lease) { 
    where("id <> COALESCE(?, 0) AND ((start_date, COALESCE(end_date, 'infinity'::timestamp)) OVERLAPS(?, COALESCE(?, 'infinity'::timestamp)))",
          lease.id, lease.start_date, lease.end_date)
  }

  default_scope { order('start_date desc') } 

  private

  # Check to make sure that no date ranges over lap
  def does_not_overlap
    if property.leases.overlapping_dates(self).any?
      self.errors.add(:start_date, :cannot_overlap)
      false
    end
  end

  # Basic end > start validation
  def end_date_after_start_date
    puts "\n******* #{end_date} -- #{start_date}\n"
    if end_date.present? && start_date.present? && end_date <= start_date
      self.errors.add(:end_date, :end_date_after_start_date)
      false
    end
  end
end
