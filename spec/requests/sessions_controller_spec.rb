require "rails_helper"

RSpec.describe "SessionsController", type: :request do
  let(:user) { create :user }

  describe "POST #create" do
    context "with valid credentials" do
      it "returns the email and auth token" do
        post "/api/v1/login", params: { session: { email: user.email, password: user.password } }

        res = JSON.parse(response.body)
        expect(res["email"]).to eq user.email
        expect(res["token"]).to eq user.reload.token
      end
    end

    context "with invalid credentials" do
      it "returns 401" do
        post "/api/v1/login", params: { session: { email: user.email, password: Faker::Internet.password } }

        expect(response.code).to eq "401"
      end
    end
  end

  describe "DELETE #destroy" do
    context "with valid credentials" do
      it "sets token to nil and returns 200" do
        expect(user.token).not_to be nil

        delete "/api/v1/logout", params: {}, headers: { authorization: "Token token=#{user.token}" }

        expect(response.code).to eq "200"
        expect(user.reload.token).to be nil
      end
    end

    context "with invalid credentials" do
      it "returns 401 and does not change token" do
        expect(user.token).not_to be nil

        delete "/api/v1/logout", params: {}, headers: { authorization: "Token token=#{user.token}dksdf" }

        expect(response.code).to eq "401"
        expect(user.reload.token).not_to be nil
      end
    end
  end
end
