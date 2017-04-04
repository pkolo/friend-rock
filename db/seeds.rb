# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Band.create(email: "p@x.com", name: "Handglops", password: "hello22")

19.times do
  Band.create(email: Faker::Internet.email, name: Faker::RockBand.name, password: "password")
end
