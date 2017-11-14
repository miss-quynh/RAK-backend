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

  def closest_projects(donor_zipcode)
    projects_in_radius = []

    @projects = project.all
    @project_zipcodes = ZipcodeReturner.closest_zipcodes(project_params[:donor_zipcode])

    @projects.each do |project|
      @project_zipcodes.each do |zip|
        if project.zip_code == zip
          projects_in_radius << project
        end
      end
    end
    projects_in_radius
  end

end
