class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.references :account, index: true
      t.string :name
      t.string :email
      t.references :user, index: true

      t.timestamps
    end

    rename_column(:leases_users, :user_id, :contact_id)
  end
end
