Donor.destroy_all
Category.destroy_all
Organization.destroy_all
Event.destroy_all
Item.destroy_all
DonationType.destroy_all
Project.destroy_all
Donation.destroy_all

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create!(name: 'Luke', movie: movies.first)
Donor.create!(first_name: "Bob", last_name: "Smith", email: "bob@bob.com", street_address: "100 Main Street", zip_code: 33333, password: "password")
categories = ['Health', 'Social', 'Environment', 'Education', 'Natural Distaster']

categories.each{ |category| Category.create!(category_name: category) }

Organization.create!(organization_name: "BigCompany", tax_code: 12388, email: "company@co.com", url: "www.company.com", mission_statement: "Disaster Relief", password: 'password', category: Category.first)

20.times do
  Donor.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, street_address: Faker::Address.street_address, city: Faker::Address.city, state: Faker::Address.state_abbr, zip_code: Faker::Address.zip_code, password: "password")
end



10.times do
  Organization.create!(organization_name: Faker::Company.name, tax_code:Faker::Company.duns_number, email: Faker::Internet.email, url: Faker::Company.logo, mission_statement: Faker::Company.buzzword, password: 'password', category: Category.all.sample)
end

10.times { Event.create!( event_name: Faker::Demographic.demonym) }

Organization.all.each do |organization|
  organization.projects << Project.new(project_name: Faker::Job.field, street_address: Faker::Address.street_address, city: Faker::Address.city, state: Faker::Address.state_abbr, zip_code: Faker::Address.zip_code, description: Faker::Lorem.paragraph, organization: organization, event: Event.all.sample)
end

donation_types = {
  Medicine: ["advil", "tylenol", "antibiotics", "bandages"],
  Food: ["Water", "Canned Goods", "Dog Food", "Baby Food"],
  Volunteer: ["Medicine", "Rescue", "Teach"],
  Money: ["Money"],
  Household: ["Soap", "Shampoo", "Toothpaste", "Detergent"]
}

donation_types.each do |category, items|
  donation = DonationType.create!(type_name: category)
  items.each { |item| Item.create!(item_name: item, donation_type: donation)}
end

3.times do
  Project.all.each do |project|
    project.donations << Donation.new(item: Item.all.sample, quantity_requested: rand(1000))
  end
end

