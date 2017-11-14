require 'rails_helper'

describe Donor do
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

  describe "associations" do
    it "has many followings" do
      expect(donor.followings).to match_array [following]
    end

    it { should have_many(:organizations).through(:followings)}
  end

  describe "validations" do
        it { should validate_presence_of(:first_name) }
        it { should validate_presence_of(:last_name) }
        it { should validate_presence_of(:email) }
        it { should validate_presence_of(:zip_code) }
  end
end
