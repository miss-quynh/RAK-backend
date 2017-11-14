class CreateFollowings < ActiveRecord::Migration[5.1]
  def change
    create_table :followings do |t|
      t.references :donor
      t.references :organization
      t.timestamps
    end
  end
end
