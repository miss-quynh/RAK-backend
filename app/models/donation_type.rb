class DonationType < ApplicationRecord
  has_many :items
  has_many :donations, through: :items
  has_many :projects, through: :donations

  validates :type_name, uniqueness: true, presence: true

end