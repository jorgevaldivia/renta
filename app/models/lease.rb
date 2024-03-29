class Lease < ActiveRecord::Base
  acts_as_tenant :account

  belongs_to :property
  has_many :invoices
  has_many :leases_users
  has_many :tenants, through: :leases_users, source: :contact
  has_one :next_invoice, -> {where("issue_date >= ?", Date.today).order("issue_date") }, class_name: "Invoice"

  FREQUENCY_TYPES = %w(days weeks months years).freeze

  monetize :rent_cents, allow_nil: true
  monetize :deposit_cents, allow_nil: true

  accepts_nested_attributes_for :tenants
  accepts_nested_attributes_for :leases_users, allow_destroy: true

  # Returns all leases, including open ones, that overlap with the given
  # lease's date range.
  scope :overlapping_dates, ->(lease) { 
    where("id <> COALESCE(?, 0) AND ((start_date, COALESCE(end_date, 'infinity'::timestamp)) OVERLAPS(?, COALESCE(?, 'infinity'::timestamp)))",
          lease.id, lease.start_date, lease.end_date)
  }

  # Returns all leases that are to be billed today.
  scope :due_today, -> { where "next_bill_date = ?", Date.today }
  # Returns all leases that have ended
  scope :ended, -> { where "end_date < current_date" }
  # Returns all current leases
  scope :current, -> { where("current_date between start_date and COALESCE(end_date, 'infinity'::timestamp)").first }

  default_scope { order('start_date desc') } 

  private

  concerning :Validations do
    included do
      validates :start_date, :interval, :rent, presence: true
      validates :frequency, inclusion: { in: FREQUENCY_TYPES }
      validates :interval, numericality: { greater_than_or_equal_to: 0 }, if: Proc.new{ |x| x.interval.present? }
      validates :rent, numericality: { greater_than_or_equal_to: 0 }, if: Proc.new{ |x| x.rent.present? }
      validates :deposit, numericality: { greater_than_or_equal_to: 0 }, if: Proc.new{ |x| x.deposit.present? }
      validate :does_not_overlap, if: Proc.new{ |x| x.start_date.present? }
      validate :end_date_after_start_date
    end

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

  concerning :Tenants do
    included do
      attr_accessor :new_tenants
      before_validation :find_or_create_new_tenants
    end

    private

    def find_or_create_new_tenants
      # self.errors.add("tenants[0].email", "errrrr")
      return unless self.new_tenants

      self.new_tenants.each_with_index do |tenant, index|
        next if tenant["email"].blank? && tenant["name"].blank?

        contact = Contact.find_or_initialize_by(email: tenant["email"])
        contact.name = tenant["name"]

        if contact.valid?
          self.tenants << contact unless self.tenant_ids.include?(contact.id)
        else
          contact.errors.messages.keys.each do |field|
            contact.errors.messages[field].each do |msg|
              self.errors.add("tenants[#{tenant["id"]}].#{field}", msg)
            end
          end
        end

      end
    end
  end

  concerning :Billing do
    included do
      # before_save :calculate_next_bill_date
      after_save :set_current_lease
      after_create :create_invoices
    end

    # Sets this as the current lease for the property if it is infact the
    # current lease.
    def set_current_lease
      if current_lease?
        property.current_lease = self
        property.save
      end
    end

    # Creates all of the invoices for the lease on creation.
    def create_invoices
      date = start_date
      # If open ended lease, then only create 10 years worth of leases
      loop_end_date = end_date || start_date + 120.month

      index = 0
      while(loop_end_date >= date)
        date = start_date.send(:+, eval("#{interval * index}.#{frequency}"))
        index += 1

        LeaseService::RentInvoicer.new(self, date).perform
      end
    end

    def current_lease?
      start_date <= Date.today && (end_date || Date.parse("2099-12-31")) >= Date.today
    end

    # Boolean for whether the lease is ending within 60 days
    def ending_soon?
      current_lease? && end_date.present? && (end_date - Date.today) <= 60
    end

    def calculate_next_bill_date
      # It's not yet time to calculate next bill date
      return if next_bill_date.present? && Date.today < next_bill_date

      if next_bill_date.present?
        # Been billed before, always go off that if available
        # Turns into something like `date + 1.month`
        date = next_bill_date = next_bill_date.send(:+, eval("#{interval}.#{frequency}"))
      else
        # Never been billed before. Go off of start date.
        if start_date >= Date.today
          self.next_bill_date = start_date
        elsif end_date.blank? || (end_date.present? && end_date >= Date.today)
          # Only calculate leases that haven't ended
          date = start_date
          index = 1
          while(Date.today > date)
            date = start_date.send(:+, eval("#{interval * index}.#{frequency}"))
            index += 1

            # Don't want people entering open leases from a long time ago
            if index >= 500
              date = nil
              break
            end
          end
        end
      end

      # Only set the next bill date if date is present and the calculated bill
      # date does not come after the lease's end date.
      if date && date <= (end_date || Date.parse("2099-12-31"))
        self.next_bill_date = date if date
      end
    end
  end
end
