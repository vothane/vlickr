FactoryGirl.define do
  sequence :name do |n|
    "Person #{n}"
  end
  
  sequence :email do |n|
    "person_#{n}@example.com"
  end

  factory :user do
    name
    email
  end

  factory :album do
    title       "Lorem Al"
    description "Lorem Something Something?"
    user
  end

 factory :video do 
    title       "Lorem Vid"
    embed_code  "oausvoipjioajvoia" 
    description "A video to show off" 
    image_url   "www.example.com/example.png" 
    file        "c:/example.mov" 
    size        "100000"  
    album
  end

  factory :comment do
    content     "Lorem Something Something?"
    video
  end
end