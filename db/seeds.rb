# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def random_string
  SecureRandom.hex(3)
end

hipster = User.create(name: "Mac User",   email: "user_#{random_string}@apple.com",     user_name: "Hipster")
nerd    = User.create(name: "Linux User", email: "user_#{random_string}@ubuntu.com",    user_name: "Nerd")
fool    = User.create(name: "Win User",   email: "user_#{random_string}@microsoft.com", user_name: "Pity_The_Fool")

assets = [
  Asset.find(:one) { |vid| vid.name == "RailsCast - ActiveRecord Relation walkthrough" },
  Asset.find(:one) { |vid| vid.name == "RailsCast - CoffeeScript" },
  Asset.find(:one) { |vid| vid.name == "Pirates of The Caribbean: On Stranger Tide" },
  Asset.find(:one) { |vid| vid.name == "Thor" },
  Asset.find(:one) { |vid| vid.name == "Transformers 3 Dark of the Moon" },
  Asset.find(:one) { |vid| vid.name == "Voodoo by Godsmack" },
  Asset.find(:one) { |vid| vid.name == "G.I. Joe 2 Retaliation" },
  Asset.find(:one) { |vid| vid.name == "Iron Sky" },
  Asset.find(:one) { |vid| vid.name == "Avengers" },
  Asset.find(:one) { |vid| vid.name == "The Amazing Spider-Man" },
  Asset.find(:one) { |vid| vid.name == "The Dark Knight Rises" },
  Asset.find(:one) { |vid| vid.name == "Wrath of the Titans" },
]

assets.each_with_index do |asset, index|
  asset = asset.first
  hipster.videos.create(:title => asset.name, :asset => asset) if index % 3 == 0
  nerd.videos.create(:title => asset.name, :asset => asset) if index % 3 == 1
  fool.videos.create(:title => asset.name, :asset => asset) if index % 3 == 2
end  