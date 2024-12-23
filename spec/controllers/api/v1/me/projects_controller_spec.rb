require 'rails_helper'

RSpec.describe Api::V1::Me::ProjectsController, type: :controller do
  include_context "admin quequeo user"

  let(:user) { admin_quequeo_user }
  let!(:project) { create(:project, user: user) }
  let!(:other_project) { create(:project, user: user) }

  before do
    token = JWT.encode({ user_id: user.id }, Rails.application.secret_key_base, 'HS256')
    request.headers['Authorization'] = "Bearer #{token}"
  end

  describe "GET #index" do
    it "returns the projects for admin@quequeo.com" do
      get :index
      expect(response).to have_http_status(:ok)
      projects = JSON.parse(response.body)
      expect(projects.size).to eq(user.projects.count)
      expect(projects.all? { |p| p['user_id'] == user.id }).to be true
    end
  end

  describe "GET #show" do
    it "returns the project if it belongs to admin@quequeo.com" do
      get :show, params: { id: project.id }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['id']).to eq(project.id)
    end
  end

  describe "POST #create" do
    let(:project_params) do
      {
        project: {
          title: "New Project",
          description: "Description of the project"
        }
      }
    end

    it "creates a new project for admin@quequeo.com" do
      expect {
        post :create, params: project_params
      }.to change { user.projects.count }.by(1)
      expect(response).to have_http_status(:created)
    end

    it "returns unprocessable entity if the data is invalid" do
      project_params[:project][:title] = nil
      post :create, params: project_params
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "PUT #update" do
    let(:update_params) do
      {
        id: project.id,
        project: {
          title: "Updated Project"
        }
      }
    end

    it "updates the project if it belongs to admin@quequeo.com" do
      put :update, params: update_params
      expect(response).to have_http_status(:ok)
      expect(project.reload.title).to eq("Updated Project")
    end
  end

  describe "DELETE #destroy" do
    it "deletes the project if it belongs to admin@quequeo.com" do
      expect {
        delete :destroy, params: { id: project.id }
      }.to change { user.projects.count }.by(-1)
      expect(response).to have_http_status(:no_content)
    end
  end
end
