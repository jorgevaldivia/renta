class AddOpenpayDataToUsers < ActiveRecord::Migration
  def change
    add_column :users, :open_pay_data, :hstore, default: {}
  end
end
