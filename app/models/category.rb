class Category < ApplicationRecord
  has_many :organizations
  has_many :projects, through: :organizations

  validates :category_name, presence: true, uniqueness: true

end