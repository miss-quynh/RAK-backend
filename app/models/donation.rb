class Donation < ApplicationRecord
  belongs_to :project
  has_one :organization, through: :project
  has_one :event, through: :project
  belongs_to :item
  has_one :donation_type, through: :item

  validates :quantity_requested, :item_id, presence: true


end