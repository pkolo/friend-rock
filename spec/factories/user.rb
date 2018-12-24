FactoryBot.define do
  factory :user do
    username { Faker::Lorem.word }
    email { Faker::Internet.email }
    password { Faker::Internet.password(10, 20, true, true) }

    trait :verified_user do
      after(:create) { |user| user.verify_email }
    end
  end
end
