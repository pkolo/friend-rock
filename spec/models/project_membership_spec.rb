require "rails_helper"

RSpec.describe ProjectMembership, type: :model do
  describe "Factory" do
    it "creates valid object" do
      expect(FactoryBot.build(:project_membership)).to be_valid
    end
  end
end
