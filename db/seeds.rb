Donor.destroy_all
Category.destroy_all
Organization.destroy_all
Event.destroy_all
Item.destroy_all
DonationType.destroy_all
Project.destroy_all
Donation.destroy_all

10.times do
  Organization.create!(organization_name: Faker::Company.name, tax_code:Faker::Company.duns_number, email: Faker::Internet.email, url: Faker::Company.logo, mission_statement: Faker::Company.buzzword, password: 'password', category: Category.all.sample)
end

10.times { Event.create!( event_name: Faker::Demographic.demonym) }

Organization.all.each do |organization|
  organization.projects << Project.new(project_name: Faker::Job.field, street_address: Faker::Address.street_address, city: Faker::Address.city, state: Faker::Address.state_abbr, zip_code: Faker::Address.zip_code, description: Faker::Lorem.paragraph, organization: organization, event: Event.all.sample)
end

3.times do
  Project.all.each do |project|
    project.donations << Donation.new(item: Item.all.sample, quantity_requested: rand(1000))
  end
end
#^^^^^^^^^^^^^^old code


#donors
20.times do
  Donor.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, street_address: Faker::Address.street_address, city: Faker::Address.city, state: Faker::Address.state_abbr, zip_code: Faker::Address.zip_code, password: "password")
end

#donations
donation_types = {
  Medicine: ["Advil", "Tylenol", "Antibiotics", "Bandages"],
  Food: ["Water", "Canned Goods", "Dog Food", "Baby Food"],
  Volunteer: ["Medicine", "Rescue", "Teach"],
  Money: ["Money"],
  Household: ["Soap", "Shampoo", "Toothpaste", "Detergent"],
  Volunteer: ["Young professional", "Helth provider", "Companion", "Labor"]
}
donation_types.each do |category, items|
  donation = DonationType.create!(type_name: category)
  items.each { |item| Item.create!(item_name: item, donation_type: donation)}
end

#events
sf_education = Event.new(event_name: "Education in San Francisco")
miscellaneous = Event.new(event_name: "Miscellaneous")


#categories
categories = ["Education", "Housing"]
categories.each { |category| Category.create!(category_name: category) }


#orgs and projects
valencia = Organization.create(organization_name: '826 Valencia St', tax_code: '043694151', email: 'christina@826valencia.org', url: 'http://826valencia.org/', mission_statement: 'TechChange is a US social enterprise which provides courses on the use of technology in addressing social and global challenges. It is a registered benefit corporation based in Washington, DC and was founded in the summer of 2010.', password: 'password', category: 1)
valencia.projects << Project.new(project_name: 'Tenderloin Center', street_address: '180 Golden Gate Ave', city: 'San Francisco', state: 'CA', zip_code: 94102, description: 'At 826 Valencia, we believe that all students deserve a chance to be successful, and we know that strong writing skills are a fundamental and proven factor in achieving that success.' organization: valencia, event: sf_education )
valencia.projects << Project.new(project_name: 'Valencia Location', street_address: '826 Valencia St', city: 'San Francisco', state: 'CA', zip_code: 94110, description: 'At 826 Valencia, we believe that all students deserve a chance to be successful, and we know that strong writing skills are a fundamental and proven factor in achieving that success.' organization: valencia, event: sf_education )


bernal = Organization.create(organization_name: 'Bernal Heights Housing Corporation', tax_code: '94-3142001', email: 'christina@BHC.org', url: 'http://www.bhnc.org/', mission_statement: 'Bernal Heights Neighborhood Center (BHNC) works to preserve and enhance the ethnic, cultural, and economic diversity of Bernal Heights and surrounding neighborhoods. We promote action to build a just and equitable community for all.', password: 'password', category_id: 2)
bernal.projects << Project.new(project_name: 'BHHC', street_address: '515 Cortland Ave', city: 'San Francisco', state: 'CA', zip_code: 94100, description: 'There are plenty of opportunities to support the work we do! For our seniors, come teach a class, serve lunch, or deliver groceries to homebound seniors.' organization: bernal, event: miscellaneous )


bethany = Organization.create(organization_name: 'Bethany Senior Housing Center', tax_code: '94-3165430', email: 'andre@bshc.org', url: 'http://www.bethanycenter.org/', mission_statement: 'Bethany Center’s core mission is to provide a home for its residents and to meet their individual needs. In addition to providing affordable and service-supported housing, Bethany Center offers programs for the whole person, programs that strengthen creativity, health, productivity and independence to greatly enhance one’s quality of life. All programs at Bethany Center are provided by Ruth’s Table, the art and wellness space located on Bethany Center’s ground floor.', password: 'password', category_id: 2)
bethany.projects << Project.new(project_name: 'BSHC', street_address: '580 Capp Street', city: 'San Francisco', state: 'CA', zip_code: 94100, description: 'There are plenty of opportunities to support the work we do! For our seniors, come teach a class, serve lunch, or deliver groceries to homebound seniors.' organization: bethany, event: miscellaneous )
bethany.projects.first.donations << Donation.new() #to be continued



