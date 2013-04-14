# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#asset_type
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def random_string
  SecureRandom.hex(3)
end

hipster = User.create(name: "Mac User",   email: "user_#{random_string}@apple.com",     user_name: "Hipster",       password: "password1", password_confirmation: "password1")
nerd    = User.create(name: "Linux User", email: "user_#{random_string}@ubuntu.com",    user_name: "Nerd",          password: "password2", password_confirmation: "password2")
fool    = User.create(name: "Win User",   email: "user_#{random_string}@microsoft.com", user_name: "Pity_The_Fool", password: "password3", password_confirmation: "password3")

assets = Asset.all

assets.each_with_index do |asset, index|
  if assets.first.asset_type = "video"
    if index % 3 == 0
      hipster.save!
      hipster.videos.create(:title => asset.name, :asset => asset)
    elsif index % 3 == 1  
      nerd.save!    
      nerd.videos.create(:title => asset.name, :asset => asset)
    else
      fool.save!
      fool.videos.create(:title => asset.name, :asset => asset)
    end
  end
end