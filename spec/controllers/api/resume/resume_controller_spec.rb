require 'rails_helper'

RSpec.describe Api::Resume::V1::ResumesController, type: :controller do
  let(:user) { create(:user) }
  let!(:resume) { create(:resume, user: user) }
  
  let(:invalid_attributes) { { title: nil, style: nil } }

  before do
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe "GET #index" do
    it "returns all resumes for the current user" do
      get :index
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(user.resumes.count)
    end
  end

  describe "POST #create" do
    context "with invalid attributes" do
      it "does not create a new resume" do
        expect do
          post :create, params: { resume: invalid_attributes }
        end.not_to change(Resume, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "GET #show" do
    it "returns the requested resume" do
      get :show, params: { id: resume.id }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["id"]).to eq(resume.id)
    end
  end

  describe "PUT #update" do
    context "with valid attributes" do
      it "updates the requested resume" do
        put :update, params: { id: resume.id, resume: { title: "Updated Resume" } }
        expect(response).to have_http_status(:ok)
        expect(resume.reload.title).to eq("Updated Resume")
      end
    end

    context "with invalid attributes" do
      it "does not update the resume" do
        put :update, params: { id: resume.id, resume: { title: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(resume.reload.title).not_to be_nil
      end
    end
  end

  describe "DELETE #destroy" do
    it "deletes the requested resume" do
      expect do
        delete :destroy, params: { id: resume.id }
      end.to change(Resume, :count).by(-1)

      expect(response).to have_http_status(:ok)
    end
  end
end
