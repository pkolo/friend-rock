require "rails_helper"

RSpec.describe BandMembership, type: :model do
  describe "Factory" do
    it "creates valid object" do
      expect(FactoryBot.build(:band_membership)).to be_valid
    end
  end
end
