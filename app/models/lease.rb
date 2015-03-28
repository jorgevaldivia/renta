class Lease < ActiveRecord::Base
  belongs_to :property

  FREQUENCY_TYPES = %w(days weeks months years).freeze

  validates :start_date, :frequency, :interval, :rent, presence: true
  validates :frequency, inclusion: { in: FREQUENCY_TYPES }
  validates :interval, numericality: { greater_than_or_equal_to: 0 }, if: Proc.new{ |x| x.interval.present? }
  validates :rent, numericality: { greater_than_or_equal_to: 0 }, if: Proc.new{ |x| x.rent.present? }
  validates :deposit, numericality: { greater_than_or_equal_to: 0 }, if: Proc.new{ |x| x.deposit.present? }

  monetize :rent_cents, allow_nil: true
  monetize :deposit_cents, allow_nil: true
end
