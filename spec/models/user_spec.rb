require "rails_helper"

RSpec.describe User, type: :model do
  describe "Factory" do
    it "creates valid object" do
      expect(FactoryBot.build(:user)).to be_valid
    end
  end

  describe "validations" do
    let!(:valid_user) { build :user, :unverified }

    it "validates presence of password" do
      invalid_user = valid_user
      invalid_user.password = nil

      expect(invalid_user).not_to be_valid
    end

    it "validates presence of email" do
      invalid_user = valid_user
      invalid_user.email = nil

      expect(invalid_user).not_to be_valid
    end

    it "validates presence of username" do
      invalid_user = valid_user
      invalid_user.username = nil

      expect(invalid_user).not_to be_valid
    end
  end

  describe "callbacks" do
    describe "after_create" do
      describe "#generate_confirmation_token" do
        let!(:user) { build :user }

        it "generates a confirmation token for the user" do
          expect(user.confirmation_token).to be nil

          user.save!

          expect(user.confirmation_token).not_to be nil
        end
      end
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

  describe "#verify_email" do
    let(:user) { create :user, :unverified }

    it "sets email_confirmed and invalidates the confirmation token" do
      expect(user.email_confirmed).to be false
      expect(user.confirmation_token).not_to be nil

      user.verify_email

      expect(user.email_confirmed).to be true
      expect(user.confirmation_token).to be nil
    end
  end
end
