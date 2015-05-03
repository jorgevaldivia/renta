class CreateLeasesUsers < ActiveRecord::Migration
  def change
    create_table :leases_users do |t|
      t.references :lease, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
