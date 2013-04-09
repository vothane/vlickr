# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Person #{n}" }
    sequence(:user_name) { |n| "User #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"} 
  end
end