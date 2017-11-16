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
      hash[:id] = donation.id
      hash[:item] = donation.item.item_name
      hash[:donation_type] = donation.item.donation_type.type_name
      hash[:quantity_requested] = donation.quantity_requested
      hash[:quantity_received] = donation.quantity_received
      donations << hash
    end
    donations
  end

  def self.projects_by_location(proj_arr, zipcode_arr)
    if zipcode_arr.class == Array && !zipcode_arr.empty?
      return proj_arr.select { |project| zipcode_arr.include?(project.zip_code) }
    else
      return proj_arr
    end
  end

# has to be an event array!
  def self.projects_by_event(proj_arr, event_arr)
    event_ids = []
    event_arr.each{ |event| event_ids << Event.find_by(event_name: event) }
    if event_arr.class == Array && !event_arr.empty?
      proj_arr.where({ event: event_ids})
    else
      proj_arr
    end
  end

  def self.projects_by_category(proj_arr, category_arr)
    if category_arr.class == Array && !category_arr.empty?
      projects_in_cat = []
      categories = Category.all.select{ |category| category_arr.include?(category.category_name)}
      categories.each do |category|
        projects_in_cat = projects_in_cat + category.projects
      end
      projects = proj_arr&projects_in_cat
    else
      projects = proj_arr
    end
  end

  def self.projects_by_type(proj_arr, donation_types_arr)
    if donation_types_arr.class == Array && !donation_types_arr.empty?
      projects = []
      donation_types_arr.each do |donation|
        found_projects = DonationType.find_by(type_name: "donation").projects
        projects = projects|found_projects
      end
      projects
    else
      proj_arr
    end
  end

  def self.organizations_by_projects(proj_arr)
    orgs = []
    proj_arr.each{ |project| orgs << project.organization }
    orgs
  end

end
