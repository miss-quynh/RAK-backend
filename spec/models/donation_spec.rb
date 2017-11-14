require 'rails_helper'

describe Donation do
  let(:project) { Project.create!(project_name: "CA Fires",
                                  street_address: "300 Mission Street",
                                  city: "Napa",
                                  state: "California",
                                  zip_code: 94552,
                                  description: "Northern California Fires",
                                  organization_id: organization.id,
                                  event_id: event.id) }
  let(:item) { Item.create!(item_name: "water bottles", image: "case of Aquafina", donation_type_id: donation_type.id) }
  let(:donation) { Donation.create!(item_id: item.id, project_id: project.id, quantity_requested: 100, quantity_received: 50) }
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
  let(:donation_type) { DonationType.create!(type_name: "Aquafina") }
  let(:event) { Event.create!(event_name: "NorCal Fires") }

  describe "associations" do
    # it "belongs to project" do
    #   expect(donation.project).to eq project
    # end

    it { should have_one(:organization)}

    it { should have_one(:event)}

    # it "belongs to item" do
    #   expect(donation.item).to eq item
    # end

    it { have_one(:donation_type) }
  end

  describe "validations" do
    it { should validate_presence_of(:quantity_requested) }

    it { should validate_presence_of(:item_id) }
  end
end
