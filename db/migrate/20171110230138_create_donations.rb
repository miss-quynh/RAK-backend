class CreateDonations < ActiveRecord::Migration[5.1]
  def change
    create_table :donations do |t|
      t.references :item
      t.references :project
      t.integer :quantity_requested
      t.integer :quantity_received, default: 0
      t.timestamps
    end
  end
end
