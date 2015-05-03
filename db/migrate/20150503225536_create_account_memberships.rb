class CreateAccountMemberships < ActiveRecord::Migration
  def change
    create_table :account_memberships do |t|
      t.references :account, index: true
      t.references :user, index: true
      t.string :role

      t.timestamps
    end
  end
end
