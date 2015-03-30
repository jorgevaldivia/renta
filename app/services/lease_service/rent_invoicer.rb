# Creates an invoice for rent when the rent is due.
class LeaseService::RentInvoicer
  def initialize(lease, date)
    @lease = lease
    @date = date
  end

  def perform
    invoice = @lease.invoices.create!(
      issue_date: @date,
      due_date: due_date,
      status: "open",
      subject: I18n.t("views.lease.rent_for_date", date: I18n.l(@date, format: :long)),
    )

    rent_line_item = invoice.line_items.create!(
      summary: Lease.human_attribute_name(:rent),
      amount: @lease.rent)
  end

  private

  # Calculate when rent is late by using the lease's grace period
  def due_date
    if @lease.grace_period.present? && @lease.grace_period >= 0
      @date + @lease.grace_period.day
    else
      @date
    end
  end
end