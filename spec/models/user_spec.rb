require "rails_helper"

RSpec.describe User, type: :model do
  describe "Factory" do
    it "creates valid object" do
      expect(FactoryBot.build(:user)).to be_valid
    end
  end

  describe ".valid_login" do
    let(:user) { create :user }

    context "if email and password is valid" do
      let(:params) { { email: user.email, password: user.password } }

      it "returns the user" do
        expect(User.valid_login?(JSON.parse(params.to_json))).to eq user
      end
    end

    context "if password is invalid" do
      let(:params) { { email: user.email, password: Faker::Internet.password } }

      it "returns nil" do
        expect(User.valid_login?(JSON.parse(params.to_json))).to be nil
      end
    end

    context "if email is invalid" do
      let(:params) { { email: Faker::Internet.email, password: user.password } }

      it "returns nil" do
        expect(User.valid_login?(JSON.parse(params.to_json))).to be nil
      end
    end
  end

  describe "#invalidate_token" do
    let(:user) { create :user }

    it "sets user token to nil" do
      expect(user.token).not_to be nil

      user.invalidate_token

      expect(user.token).to be nil
    end
  end
end
