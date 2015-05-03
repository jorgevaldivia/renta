class AddDetailsToProperties < ActiveRecord::Migration
  def change
    add_column :properties, :beds, :float
    add_column :properties, :baths, :float
    add_column :properties, :size, :integer
    add_column :properties, :size_unit, :string
  end
end
