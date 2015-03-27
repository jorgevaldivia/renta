class AddMoneyStatsToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :total_revenue_cents, :integer
    add_column :properties, :total_expenses_cents, :integer
    add_column :properties, :total_profit_cents, :integer
  end
end
