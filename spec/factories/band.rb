FactoryBot.define do
  factory :band do
    name { Faker::Lorem.word.capitalize }
    bio { Faker::Lorem.paragraph }

    transient do
      members { [] }
      number_of_members { 3 }
    end

    after(:create) do |band, evaulator|
      if evaulator.members.any?
        build :band_membership, user: member, band: band
      else
        evaulator.number_of_members.times { |n| create :band_membership, band: band }
      end
    end
  end
end
