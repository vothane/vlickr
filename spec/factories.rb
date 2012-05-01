FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}   
  end
end

Factory.define :album do |album|
  album.title       "Lorem Al"
  album.description "Lorem Something Something?"
  album.association :user
end

Factory.define :video do |video|
  video.title       "Lorem Vid"
  video.embed_code  "oausvoipjioajvoia" 
  video.description "A video to show off" 
  video.image_url   "www.example.com/example.png" 
  video.file        "c:/example.mov" 
  video.size        "100000"  
  video.association :album
end

Factory.define :comment do |comment|
  comment.content     "Lorem Something Something?"
  comment.association :video
end
