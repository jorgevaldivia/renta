class CreateBankAccounts < ActiveRecord::Migration
  def change
    create_table :bank_accounts do |t|
      t.references :user, index: true
      t.string :holder_name
      t.string :clabe
      t.hstore :open_pay_data, default: {}

      t.timestamps
    end
  end
end
