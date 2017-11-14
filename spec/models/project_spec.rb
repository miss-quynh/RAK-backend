require 'rails_helper'

describe Project do
  let(:category) { Category.create!(category_name: "Healthcare") }

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
  let(:project) { Project.create!(project_name: "CA Fires",
                                  street_address: "300 Mission Street",
                                  city: "Napa",
                                  state: "California",
                                  zip_code: 94552,
                                  description: "Northern California Fires",
                                  organization_id: organization.id,
                                  event_id: event.id) }
  let(:donation_type) { DonationType.create!(type_name: "Aquafina") }
  let(:item) { Item.create!(item_name: "water bottles", image: "case of Aquafina", donation_type_id: donation_type.id) }
  let(:donation) { Donation.create!(item_id: item.id, project_id: project.id, quantity_requested: 100, quantity_received: 50) }

  describe "associations" do
    it "belongs to organization" do
      expect(project.organization).to eq organization
    end

    it "belongs to event" do
      expect(project.event).to eq event
    end

    it "has one category" do
      expect(project.category).to eq category
    end

    it "has many donations" do
      expect(project.donations).to match_array [donation]
    end

    it { should have_many(:items).through(:donations)}

    it { should have_many(:donation_types).through(:items)}

  end



  describe "validations" do
    it { should validate_presence_of(:project_name) }

    it { should validate_presence_of(:description) }

    it { should validate_presence_of(:zip_code) }
  end
end
