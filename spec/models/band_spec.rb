require "rails_helper"

RSpec.describe Band, type: :model do
  describe "Factory" do
    it "creates valid object" do
      expect(FactoryBot.build(:band)).to be_valid
    end
  end
end
