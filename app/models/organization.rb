class Organization < ApplicationRecord
  has_secure_password

  has_many :followings
  has_many :projects
  belongs_to :category
  has_many :donors, through: :followings
  has_many :donations, through: :projects
  has_many :events, through: :projects
  has_many :items, through: :donations
  has_many :donation_types, through: :items

  validates :organization_name, :tax_code, :email, :category, presence: true
  validates :email, :organization_name, uniqueness: true

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  def image_url
    self.avatar.url
  end
end
