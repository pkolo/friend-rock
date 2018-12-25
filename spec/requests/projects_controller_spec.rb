require "rails_helper"

RSpec.describe "ProjectsController", type: :request do
  describe "POST #create" do
    let!(:user) { create :user }
    let(:project_attrs) { attributes_for :project }

    context "with valid user token" do
      it "creates a project, associates the current user, sends a mailer" do
        expect(Project.all.length).to eq 0
        expect(ActionMailer::Base.deliveries.length).to eq 0

        post "/api/v1/projects", params: { project: project_attrs }, headers: { authorization: "Token token=#{user.token}" }

        expect(response.code).to eq "200"

        expect(Project.all.length).to eq 1
        project = Project.first
        expect(project.name).to eq project_attrs[:name]
        expect(project.bio).to eq project_attrs[:bio]
        expect(project.owner).to eq user

        expect(ActionMailer::Base.deliveries.length).to eq 1
        expect(ActionMailer::Base.deliveries.first.to).to include user.email
        expect(ActionMailer::Base.deliveries.first.subject).to eq UserMailer.new_project_created(project, user).subject
      end
    end

    context "without invalid token" do
      it "returns 401" do
        post "/api/v1/projects", params: { project: project_attrs }, headers: { authorization: "Token token=#{user.token[0..-2]}" }

        expect(response.code).to eq "401"
      end
    end
  end

  describe "GET #show" do
    let(:project) { create :project }

    context "without token" do
      it "returns project" do
        get "/api/v1/projects/#{project.id}"

        expect(response.code).to eq "200"
        res = JSON.parse(response.body)

        expect(res["name"]).to eq project.name
        expect(res["bio"]).to eq project.bio
      end
    end
  end
end
