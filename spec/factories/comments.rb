# Read about factories at https://github.com/thoughtbot/factory_girl
require 'factory_girl'

FactoryGirl.define do
  factory :comment do
    content "MyText"
    video_id 1
  end
end
