class AddCurrentLeaseToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :current_lease_id, :integer
    add_index :properties, :current_lease_id
  end
end
