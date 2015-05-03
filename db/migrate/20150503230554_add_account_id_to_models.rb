class AddAccountIdToModels < ActiveRecord::Migration
  def change
    add_column :invoices, :account_id, :integer
    add_column :invoice_line_items, :account_id, :integer
    add_column :leases, :account_id, :integer
    add_column :leases_users, :account_id, :integer
    add_column :properties, :account_id, :integer
    add_column :transactions, :account_id, :integer

    add_index :invoices, :account_id
    add_index :invoice_line_items, :account_id
    add_index :leases, :account_id
    add_index :leases_users, :account_id
    add_index :properties, :account_id
    add_index :transactions, :account_id
  end
end
