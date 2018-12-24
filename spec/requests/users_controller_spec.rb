require "rails_helper"

RSpec.describe "UsersController", type: :request do
  describe "POST #create" do
    let(:user_attrs) { attributes_for :user }

    context "with valid attributes" do
      it "creates user, sends mailer, and returns ok" do
        expect(User.all.length).to eq 0
        expect(ActionMailer::Base.deliveries.length).to eq 0

        post "/api/v1/users", params: { user: user_attrs }

        expect(response.code).to eq "200"

        expect(User.all.length).to eq 1
        user = User.first
        expect(user.username).to eq user_attrs[:username]
        expect(user.email).to eq user_attrs[:email]
        expect(user.password_digest).not_to be nil

        expect(ActionMailer::Base.deliveries.length).to eq 1
        expect(ActionMailer::Base.deliveries.first.to).to include user.email
        expect(ActionMailer::Base.deliveries.first.subject).to eq UserMailer.registration_confirmation(user).subject
      end
    end

    context "with invalid attributes" do
      before { user_attrs.delete(:email) }

      it "returns forbidden" do
        expect(User.all.length).to eq 0

        post "/api/v1/users", params: { user: user_attrs }

        expect(response.code).to eq "401"

        expect(User.all.length).to eq 0
      end
    end
  end
end
