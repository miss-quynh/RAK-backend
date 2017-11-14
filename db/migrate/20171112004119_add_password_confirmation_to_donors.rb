class AddPasswordConfirmationToDonors < ActiveRecord::Migration[5.1]
  def change
    add_column :donors, :password_confirmation, :string
  end
end
