# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

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

assets.each do |asset|
  asset = asset.first
  Video.find_or_initialize_by(:title => asset.name).tap do |video|
    video.title = asset.name
    video.asset = asset
    video.save!
  end  
end  