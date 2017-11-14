require 'rails_helper'

describe Organization do

  let(:organization) { Organization.create!(
                        organization_name: "Red Cross",
                        tax_code: 94124,
                        email: "rc@rc.com",
                        url: "redcross.com",
                        mission_statement: "hello",
                        password: "password",
                        category_id: category.id)
                      }
  let(:event) { Event.create!(event_name: "NorCal Fires") }
  let(:following) {Following.create!(donor_id: donor.id, organization_id: organization.id)}
  let(:project) { Project.create!(project_name: "Northern California", street_address: "100 Main Street", city: "Napa", state: "CA", zip_code: 95448, description: "Fire", organization_id: organization.id, event_id: event.id) }
  let(:category) { Category.create!(category_name: "Healthcare") }
  let(:donor) { Donor.create!(first_name: "Bob", last_name: "Smith", email: "bob@bob.com", street_address: "100 Market Street", city: "Napa", state: "CA", zip_code: 95548, password: "password") }
  let(:donations) { Donation.create!(item_id: item.id, project_id: project.id, quantity_requested: 100, quantity_received: 50) }
  let(:items) { Item.create!(item_name: "water bottles", image: "case of Aquafina", donation_type_id: donation_type.id) }
  let(:donation_type) { Donation_type.create!(type_name: "Aquafina") }


  describe "associations" do
    it "has many followings" do
      expect(organization.followings).to match_array [following]
    end

    it "has many projects" do
      expect(organization.projects).to match_array [project]
    end

    it "belongs to category" do
      expect(organization.category).to eq category
    end

    it { should have_many(:donors).through(:followings)}

    it { should have_many(:donations).through(:projects)}

    it { should have_many(:events).through(:projects)}

    it { should have_many(:items).through(:donations)}

    it { should have_many(:donation_types).through(:items)}
    end

  describe "validations" do
    it "is valid when an organization has a name" do
      organization.organization_name = "Red Cross"
      organization.valid?
      expect(organization.errors[:organization_name]).to be_empty
    end

    it "is invalid when an organization does not have a name" do
      organization.organization_name = nil
      organization.valid?
      expect(organization.errors[:organization_name]).not_to be_empty
    end

    it "is valid when an organization has a tax code number" do
      organization.tax_code = "14569"
      organization.valid?
      expect(organization.errors[:tax_code]).to be_empty
    end

    it "is invalid when an organization does not have a tax code number" do
      organization.tax_code = nil
      organization.valid?
      expect(organization.errors[:tax_code]).not_to be_empty
    end

    it "is valid when an organization has an email address" do
      organization.email = "redcross@help.com"
      organization.valid?
      expect(organization.errors[:email]).to be_empty
    end

    it "is invalid when an organization does not have an email address" do
      organization.email = nil
      organization.valid?
      expect(organization.errors[:email]).not_to be_empty
    end

    it "is valid when an organization has a category" do
      organization.category = Category.new
      organization.valid?
      expect(organization.errors[:category]).to be_empty
    end

    it "is invalid when an organization does not have a category" do
      organization.category = nil
      organization.valid?
      expect(organization.errors[:category]).not_to be_empty
    end
  end

end
