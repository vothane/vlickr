# Read about factories at https://github.com/thoughtbot/factory_girl

def random_string
  SecureRandom.hex(3)
end

FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Person #{n}" }
    sequence(:user_name) { |n| "User #{n}" }
    sequence(:email) { |n| "person_#{n}#{random_string}@example.com"}    
    password "foobar"
    password_confirmation "foobar"
  end
end