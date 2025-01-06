require 'rails_helper'

RSpec.describe Api::Resume::V1::SectionsController, type: :controller do
  let(:user) { create(:user) }
  let!(:resume) { create(:resume, user: user) }
  let!(:section) { create(:section, resume: resume) }
  let(:valid_attributes) { { title: "New Section", content: "Section Content" } }
  let(:invalid_attributes) { { title: nil, content: nil } }

  before do
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new section" do
        expect do
          post :create, params: { resume_id: resume.id, section: valid_attributes }
        end.to change(Section, :count).by(1)

        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)["title"]).to eq("New Section")
      end
    end

    context "with invalid attributes" do
      it "does not create a new section" do
        expect do
          post :create, params: { resume_id: resume.id, section: invalid_attributes }
        end.not_to change(Section, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PUT #update" do
    context "with valid attributes" do
      it "updates the section" do
        put :update, params: { id: section.id, section: { title: "Updated Title" } }
        expect(response).to have_http_status(:ok)
        expect(section.reload.title).to eq("Updated Title")
      end
    end

    context "with invalid attributes" do
      it "does not update the section" do
        put :update, params: { id: section.id, section: { title: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(section.reload.title).not_to eq(nil)
      end
    end
  end

  describe "DELETE #destroy" do
    it "deletes the section" do
      expect do
        delete :destroy, params: { id: section.id }
      end.to change(Section, :count).by(-1)

      expect(response).to have_http_status(:ok)
    end

    it "returns an error if the section cannot be deleted" do
      allow_any_instance_of(Section).to receive(:destroy).and_return(false)
      delete :destroy, params: { id: section.id }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)).to have_key("errors")
    end
  end
end
