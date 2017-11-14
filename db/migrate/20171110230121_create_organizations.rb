class CreateOrganizations < ActiveRecord::Migration[5.1]
  def change
    create_table :organizations do |t|
      t.string :organization_name, null: false
      t.integer :tax_code, null: false
      t.string :email, null: false
      t.string :url
      t.text :mission_statement
      t.string :password_digest
      t.references :category, null: false
      t.string :organization_logo
      t.timestamps
    end
  end
end
