class Item < ApplicationRecord
  has_many :donations
  belongs_to :donation_type
  has_many :projects, through: :donations

  validates :donation_type, presence: true
end