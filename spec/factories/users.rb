FactoryGirl.define do
  sequence :username do |n|
    "ios_user##{n}"
  end

  factory :user do
    username
    email 'ios_user@example.com'
    password 'alcatraz'
  end
end
