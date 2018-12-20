require "rails_helper"

RSpec.describe Project, type: :model do
  describe "Factory" do
    it "creates valid object" do
      expect(FactoryBot.build(:project)).to be_valid
    end
  end
end
