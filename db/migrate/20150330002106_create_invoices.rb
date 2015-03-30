class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.references :user, index: true
      t.references :lease, index: true
      t.string :subject
      t.date :issue_date
      t.date :due_date
      t.string :status
      t.integer :total_amount_cents
      t.text :notes

      t.timestamps
    end
  end
end
