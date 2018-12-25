FactoryBot.define do
  factory :project do
    name { Faker::Lorem.word.capitalize }
    bio { Faker::Lorem.paragraph }

    transient do
      members { [] }
      number_of_members { 3 }
    end

    after(:build) do |project, evaluator|
      project.user = build :user
    end

    after(:create) do |project, evaluator|
      if evaluator.members.any?
        build :project_membership, user: member, project: project
      else
        evaluator.number_of_members.times { |n| create :project_membership, project: project }
      end
    end
  end
end
