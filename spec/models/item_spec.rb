require 'rails_helper'

describe Item do
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
  let(:following) { Following.create!(donor_id: donor.id, organization_id: organization.id)}
  let(:donor) { Donor.create!(
                first_name: "Robert",
                last_name: "Bobby",
                email:      "donor@donor.com",
                street_address: "300 Mission Street",
                city: "Napa",
                state: "California",
                zip_code: 94552,
                password: "password")
              }
  let(:donation_type) { DonationType.create!(type_name: "Aquafina") }
  let(:item) { Item.create!(item_name: "water bottles", image: "case of Aquafina", donation_type_id: donation_type.id) }
  let(:donation) { Donation.create!(item_id: item.id, project_id: project.id, quantity_requested: 100, quantity_received: 50) }

  describe "associations" do
    it "has many donations" do
      expect(item.donations).to match_array [donation]
    end
    it { should belong_to(:donation_type) }
    it { should have_many(:projects).through(:donations)}
  end

  describe "validations" do
    it { should validate_presence_of(:item_name) }
    it { should validate_presence_of(:donation_type) }
  end

end
