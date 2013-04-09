# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :video do
    sequence(:title) { |n| "title #{n}" }
    association :user, :factory => :user
  end
end
