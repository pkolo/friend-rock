# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Band.create(email: "p@x.com", name: "Handglops", password: "hello22", city: "Brooklyn", state: "NY", country: "USA")

locations = [
  {
    city: "Toledo",
    state: "OH",
    country: "USA"
  },
  {
    city: "Toronto",
    state: "ON",
    country: "Canada"
  },
  {
    city: "Sacramento",
    state: "CA",
    country: "USA"
  },
  {
    city: "Columbus",
    state: "OH",
    country: "USA"
  },
  {
    city: "Chicago",
    state: "IL",
    country: "USA"
  }
]

genres = ["Bubblegum", "Garage Pop", "Punk", "New Wave", "Lo-Fi", "Indiepop", "Postpunk", "Indie Rock", "Hardcore", "Synthpop", "Metal", "Darkwave", "Hometaper", "Pop", "Rock n Roll"]

19.times do
  loc = locations.sample
  band = Band.create(email: Faker::Internet.email, name: Faker::RockBand.name, password: "password", city: loc[:city], state: loc[:state], country: loc[:country])
  3.times do
    band.genre_list.add(genres.sample)
    band.save
  end
end

# Band.all.each do |band|
#   3.times do
#     band_two = Band.all.sample
#     Relationship.find_or_create_by(band_one: band, band_two: band_two, action_band: band, status: 0)
#   end
#
#   5.times do
#     band_two = Band.all.sample
#     Relationship.find_or_create_by(band_one: band, band_two: band_two, action_band: band_two, status: 1)
#   end
# end
