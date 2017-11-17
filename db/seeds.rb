Donor.destroy_all
Category.destroy_all
Organization.destroy_all
Event.destroy_all
Item.destroy_all
DonationType.destroy_all
Project.destroy_all
Donation.destroy_all


#categories
categories = ["Education", "Housing", "Health", "Natural Disaster Aid","Environmental"]
categories.each { |category| Category.create!(category_name: category) }


#donors
20.times do
  Donor.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, street_address: Faker::Address.street_address, city: Faker::Address.city, state: Faker::Address.state_abbr, zip_code: Faker::Address.zip_code, password: "password")
end

#donations
donation_types = {
  Medicine: ["Advil", "Tylenol", "Antibiotics", "Bandages"],
  Food: ["Water", "Canned Goods", "Dog Food", "Baby Food"],
  Money: ["Money"],
  Household: ["Soap", "Shampoo", "Toothpaste", "Detergent"],
  Volunteer: ["Young professional", "Health provider", "Companion", "Labor"]
}
donation_types.each do |category, items|
  donation = DonationType.create!(type_name: category)
  items.each { |item| Item.create!(item_name: item, donation_type: donation, image: GettyImagesAdaptor.return_image(item))}
end

#events
sf_education = Event.new(event_name: "Education in San Francisco")
miscellaneous = Event.new(event_name: "Miscellaneous")

#orgs and projects
valencia = Organization.create(organization_name: '826 Valencia St', tax_code: '043694151', email: 'christina@826valencia.org', url: 'http://826valencia.org/', mission_statement: 'TechChange is a US social enterprise which provides courses on the use of technology in addressing social and global challenges. It is a registered benefit corporation based in Washington, DC and was founded in the summer of 2010.', password: 'password', category: Category.first)
valencia.projects << Project.new(project_name: 'Tenderloin Center', street_address: '180 Golden Gate Ave', city: 'San Francisco', state: 'CA', zip_code: 94102, description: 'At 826 Valencia, we believe that all students deserve a chance to be successful, and we know that strong writing skills are a fundamental and proven factor in achieving that success.', organization: valencia, event: sf_education )
valencia.projects << Project.new(project_name: 'Valencia Location', street_address: '826 Valencia St', city: 'San Francisco', state: 'CA', zip_code: 94110, description: 'At 826 Valencia, we believe that all students deserve a chance to be successful, and we know that strong writing skills are a fundamental and proven factor in achieving that success.', organization: valencia, event: sf_education )
valencia.projects.first.donations << Donation.new(item: Item.all.sample, quantity_requested: rand(1000))
valencia.projects.first.donations << Donation.new(item: Item.all.sample, quantity_requested: rand(1000))
valencia.projects.first.donations << Donation.new(item: Item.all.sample, quantity_requested: rand(1000))
valencia.projects.last.donations << Donation.new(item: Item.all.sample, quantity_requested: rand(1000))
valencia.projects.last.donations << Donation.new(item: Item.all.sample, quantity_requested: rand(1000))
valencia.projects.last.donations << Donation.new(item: Item.all.sample, quantity_requested: rand(1000))


bernal = Organization.create(organization_name: 'Bernal Heights Housing Corporation', tax_code: '94-3142001', email: 'christina@BHC.org', url: 'http://www.bhnc.org/', mission_statement: 'Bernal Heights Neighborhood Center (BHNC) works to preserve and enhance the ethnic, cultural, and economic diversity of Bernal Heights and surrounding neighborhoods. We promote action to build a just and equitable community for all.', password: 'password', category_id: 2)
bernal.projects << Project.new(project_name: 'BHHC', street_address: '515 Cortland Ave', city: 'San Francisco', state: 'CA', zip_code: 94100, description: 'There are plenty of opportunities to support the work we do! For our seniors, come teach a class, serve lunch, or deliver groceries to homebound seniors.', organization: bernal, event: miscellaneous )
bernal.projects.first.donations << Donation.new(item: Item.all.sample, quantity_requested: rand(1000))
bernal.projects.first.donations << Donation.new(item: Item.all.sample, quantity_requested: rand(1000))
bernal.projects.first.donations << Donation.new(item: Item.all.sample, quantity_requested: rand(1000))
bernal.projects.first.donations << Donation.new(item: Item.all.sample, quantity_requested: rand(1000))

bethany = Organization.create(organization_name: 'Bethany Senior Housing Center', tax_code: '94-3165430', email: 'andre@bshc.org', url: 'http://www.bethanycenter.org/', mission_statement: 'Bethany Center’s core mission is to provide a home for its residents and to meet their individual needs. In addition to providing affordable and service-supported housing, Bethany Center offers programs for the whole person, programs that strengthen creativity, health, productivity and independence to greatly enhance one’s quality of life. All programs at Bethany Center are provided by Ruth’s Table, the art and wellness space located on Bethany Center’s ground floor.', password: 'password', category: Category.find_by(category_name: 'Housing'))
bethany.projects << Project.new(project_name: 'BSHC', street_address: '580 Capp Street', city: 'San Francisco', state: 'CA', zip_code: 94100, description: 'There are plenty of opportunities to support the work we do! For our seniors, come teach a class, serve lunch, or deliver groceries to homebound seniors.', organization: bethany, event: miscellaneous )
bethany.projects.first.donations << Donation.new(item: Item.all.sample, quantity_requested: rand(1000))
bethany.projects.first.donations << Donation.new(item: Item.all.sample, quantity_requested: rand(1000))
bethany.projects.first.donations << Donation.new(item: Item.all.sample, quantity_requested: rand(1000))

orgs_sample = ['BRAC', 'The Wikimedia Foundation', 'Acumen Fund', 'Danish Refugee Council', 'Partners in Health', 'Ceres', 'CARE International', 'Médecins Sans Frontières', 'Cure Violence', 'Mercy Corps', 'Apopo', 'Root Capital', 'Handicap International', 'IRC', 'Barefoot College', 'Landesa', 'Ashoka', 'One Acre Fund', 'Clinton Health Access Initiative', 'Heifer International']

descriptions = ["Non-governmental organizations, nongovernmental[1] organizations, or nongovernment organizations,[2][3] commonly referred to as NGOs,[4] are international organizations and generally nonprofit organizations independent of specific governments (though often funded by governments) that are active in humanitarian, educational, healthcare, public policy, social, human rights, environmental, and other areas to effect changes according to their objectives. They are thus a subgroup of all organizations founded by citizens, which include clubs and other associations that provide services, benefits, and premises only to members. Sometimes the term is used as a synonym of 'civil society organization' to refer to any association founded by citizens, but this is not how the term is normally used in the media or everyday language, as recorded by major dictionaries. The explanation of the term by NGO.org (the non-governmental organizations associated with the United Nations) is ambivalent. It first says an NGO is any non-profit, voluntary citizens' group which is organized on a local, national or international level, but then goes on to restrict the meaning in the sense used by most English speakers and the media: Task-oriented and driven by people with a common interest, NGOs perform a variety of service and humanitarian functions, bring citizen concerns to Governments, advocate and monitor policies and encourage political particpation through provision of information.",  "NGOs are usually funded by donations, but some avoid formal funding altogether and are run primarily by volunteers. NGOs are highly diverse groups of organizations engaged in a wide range of activities, and take different forms in different parts of the world. Some may have charitable status, while others may be registered for tax exemption based on recognition of social purposes. Others may be fronts for political, religious, or other interests. Since the end of World War II, NGOs have had an increasing role in international development, particularly in the fields of humanitarian assistance and poverty alleviation.", "The number of NGOs worldwide is estimated to be 10 million. Russia had about 277,000 NGOs in 2008. India is estimated to have had around 2 million NGOs in 2009, just over one NGO per 600 Indians, and many times the number of primary schools and primary health centres in India. China is estimated to have approximately 440,000 officially registered NGOs. About 1.5 million domestic and foreign NGOs operated in the United States in 2017.", "The term 'NGO' is not always used consistently. In some countries the term NGO is applied to an organization that in another country would be called an NPO (nonprofit organization), and vice versa. Political parties and trade unions are considered NGOs only in some countries. There are many different classifications of NGO in use. The most common focus is on 'orientation' and 'level of operation'. An NGO's orientation refers to the type of activities it takes on. These activities might include human rights, environmental, improving health, or development work. An NGO's level of operation indicates the scale at which an organization works, such as local, regional, national, or international.", 'The term "non-governmental organization" was first coined in 1945, when the United Nations (UN) was created. The UN, itself an intergovernmental organization, made it possible for certain approved specialized international non-state agencies — i.e., non-governmental organizations — to be awarded observer status at its assemblies and some of its meetings. Later the term became used more widely. Today, according to the UN, any kind of private organization that is independent from government control can be termed an "NGO", provided it is not-for-profit, nonprevention,rification needed] but not simply an opposition political party.', 'One characteristic these diverse organizations share is that their non-profit status means they are not hindered by short-term financial objectives. Accordingly, they are able to devote themselves to issues which occur across longer time horizons, such as climate change, malaria prevention, or a global ban on landmines. Public surveys reveal that NGOs often enjoy a high degree of public trust, which can make them a useful – but not always sufficient – proxy for the concerns of society and stakeholders.']

orgs_sample.each do |org|
  cat = Category.all.sample
  url = "www.#{org}.com"
  Organization.create(organization_name: org, tax_code: Faker::Company.duns_number, email: Faker::Internet.email, url: url, mission_statement: "descriptions.sample", password: 'password', category: cat )
end

# bethany = Organization.create(organization_name: 'Bethany Senior Housing Center', tax_code: '94-3165430', email: 'andre@bshc.org', url: 'http://www.bethanycenter.org/', mission_statement: 'Bethany Center’s core mission is to provide a home for its residents and to meet their individual needs. In addition to providing affordable and service-supported housing, Bethany Center offers programs for the whole person, programs that strengthen creativity, health, productivity and independence to greatly enhance one’s quality of life. All programs at Bethany Center are provided by Ruth’s Table, the art and wellness space located on Bethany Center’s ground floor.', password: 'password', category: Category.find_by(category_name: 'Housing'))




