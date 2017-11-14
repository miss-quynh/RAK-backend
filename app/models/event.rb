class Event < ApplicationRecord
  has_many :projects
  has_many :organizations, through: :projects
  has_many :donations, through: :projects

  validates :event_name, presence: true, uniqueness: true

end