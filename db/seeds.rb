# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#asset_type
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

hipster = User.create!(name: "Mac User",     email: "hip@apple.com",     user_name: "Hipster",       password: "password1", password_confirmation: "password1")
nerd    = User.create!(name: "Linux User",   email: "pro@ubuntu.com",    user_name: "Nerd",          password: "password2", password_confirmation: "password2")
fool    = User.create!(name: "Win User",     email: "dumb@microsoft.com", user_name: "Pity_The_Fool", password: "password3", password_confirmation: "password3")
bro     = User.create!(name: "Vagrant User", email: "great@ruby.com",      user_name: "BadAssMoFo",    password: "password4", password_confirmation: "password4")

bro.toggle!(:admin)

assets = Asset.all

assets.each_with_index do |asset, index|
  if assets.first.asset_type = "video"
    mod = index % 4
    case mod
      when 0
        hipster.videos.create(:title => asset.name, :asset => asset)
      when 1 
        nerd.videos.create(:title => asset.name, :asset => asset)
      when 2 
        bro.videos.create(:title => asset.name, :asset => asset)
      else
        fool.videos.create(:title => asset.name, :asset => asset)
    end
  end
end

hipster.follow!(nerd)
hipster.follow!(fool)
hipster.follow!(bro)
nerd.follow!(bro)
nerd.follow!(fool)
fool.follow!(bro)