FactoryBot.define do
  factory :user do
    username { Faker::Lorem.word }
    email { Faker::Internet.email }
    password { Faker::Internet.password(10, 20, true, true) }
    confirmation_token { nil }
    email_confirmed { true }

    trait :unverified do
      confirmation_token { SecureRandom.urlsafe_base64.to_s }
      email_confirmed { false }
    end
  end
end
