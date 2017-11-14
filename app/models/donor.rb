class Donor < ApplicationRecord
  has_many :followings
  has_many :organizations, through: :followings

  validates :first_name, :last_name, :email, :zip_code, presence: true
  validates :email, uniqueness: true

  has_secure_password
end