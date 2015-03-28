class AddNextBillDateToLeases < ActiveRecord::Migration
  def change
    add_column :leases, :next_bill_date, :date
  end
end
