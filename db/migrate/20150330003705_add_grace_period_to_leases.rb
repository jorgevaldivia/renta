class AddGracePeriodToLeases < ActiveRecord::Migration
  def change
    add_column :leases, :grace_period, :integer
    add_column :leases, :user_id, :integer

    add_index :leases, :user_id
  end
end
