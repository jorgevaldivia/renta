class CreateInvoiceLineItems < ActiveRecord::Migration
  def change
    create_table :invoice_line_items do |t|
      t.references :invoice, index: true
      t.string :summary
      t.integer :amount_cents

      t.timestamps
    end
  end
end
