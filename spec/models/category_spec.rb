require 'rails_helper'

describe Category do
  let(:category) { Category.create!(category_name: "Healthcare") }

  describe "validations" do
    it { should have_many(:organizations) }

    it { should have_many(:projects).through(:organizations)}
  end

  describe "validations" do
    it { should validate_presence_of(:category_name) }
  end

#   let(:project) { Project.create!(project_name: "Northern California", street_address: "100 Main Street", city: "Napa", state: "CA", zip_code: 95448, description: "Fire", organization_id: organization.id, event_id: event.id) }
#   describe "associations" do


#   describe "validations" do
#     it { should validate_presence_of(:category_name) }
#   end

end