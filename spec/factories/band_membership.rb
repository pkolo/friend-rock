FactoryBot.define do
  factory :band_membership do
    band
    user
    role { ["Guitar", "Drums", "Bass", "Producer"].sample }
  end
end
