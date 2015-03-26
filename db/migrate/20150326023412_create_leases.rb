class CreateLeases < ActiveRecord::Migration
  def change
    create_table :leases do |t|
      t.references :property, index: true
      t.date :start_date
      t.date :end_date
      t.string :frequency
      t.integer :interval
      t.integer :deposit_cents
      t.integer :rent_cents

      t.timestamps
    end
  end
end
