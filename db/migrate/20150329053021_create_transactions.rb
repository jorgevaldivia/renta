class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.references :user, index: true
      t.string :item_type
      t.integer :item_id
      t.integer :amount_cents
      t.string :transaction_type
      t.string :summary
      t.text :description

      t.timestamps
    end
    add_index :transactions, :item_id
  end
end
