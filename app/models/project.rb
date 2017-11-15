class Project < ApplicationRecord


  belongs_to :organization
  belongs_to :event
  has_one :category, through: :organization
  has_many :donations
  has_many :items, through: :donations
  has_many :donation_types, through: :items

  validates :project_name, :description, :zip_code, presence: true

  def project_donations
    donations = []
    self.donations.each do |donation|
      hash = Hash.new()
      hash[:item] = donation.item.item_name
      hash[:quantity_requested] = donation.quantity_requested
      hash[:quantity_received] = donation.quantity_received
      donations << hash
    end
    donations
  end

  def self.projects_by_location(proj_arr, zipcode_arr)
    if !zipcode_arr.empty?
      return proj_arr.select { |project| zipcode_arr.include?(project.zip_code) }
    else
      return proj_arr
    end
  end

# has to be an event array!
  def self.projects_by_event(proj_arr, event_arr)
    if !event_arr.empty?
      proj_arr.where({ event: event_arr})
    else
      proj_arr
    end
  end

  def self.projects_by_category(proj_arr, category_arr)
    if !category_arr.empty?
      projects_in_cat = []
      category_arr.each do |category|
        projects_in_cat = projects_in_cat | category.projects
      end
      projects = proj_arr&projects_in_cat
    else
      projects = proj_arr
    end
    projects
  end

  def self.projects_by_type(proj_arr, donation_types_arr)
    if !event_arr.empty?
      proj_arr.where({ event: event_arr})
    else
      proj_arr
    end
  end

end
