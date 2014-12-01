FactoryGirl.define do
  factory :user do
    email 'ios_user@example.com'
    password 'alcatraz'

    trait :full do
      reset_password_token { Devise.token_generator.generate(User, :reset_password_token) }
      reset_password_sent_at { Time.now }
      remember_created_at { Time.now }
    end
  end
end
