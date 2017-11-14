class CreateDonors < ActiveRecord::Migration[5.1]
  def change
    create_table :donors do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :street_address
      t.string :city
      t.string :state
      t.integer :zip_code, null: false
      t.string :password_digest
      t.timestamps
    end
  end
end
