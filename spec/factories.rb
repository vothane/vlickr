Factory.define :user do |user|
  user.name  "Some One"
  user.email "Somel@example.com"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.sequence :name do |n|
  "Person #{n}"
end

Factory.define :comment do |comment|
  comment.content "Lorem Something Something?"
  comment.association :user
end