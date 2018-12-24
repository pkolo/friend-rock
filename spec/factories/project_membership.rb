FactoryBot.define do
  factory :project_membership do
    project
    user
    role { ["Guitar", "Drums", "Bass", "Producer"].sample }
  end
end
