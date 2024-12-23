require 'rails_helper'

RSpec.describe Api::V1::Me::UsersController, type: :controller do
  include_context "admin quequeo user"

  let(:admin_user) { admin_quequeo_user }

  let(:valid_update_params) do
    {
      id: admin_user.id,
      project: {
        email: "new_admin@quequeo.com"
      }
    }
  end

  let(:invalid_update_params) do
    {
      id: admin_user.id,
      project: {
        email: nil
      }
    }
  end

  before do
    allow(controller).to receive(:current_user).and_return(admin_user)
  end

  describe "GET #show" do
    it "returns the current user's information" do
      get :show, params: { id: admin_user.id }
      expect(response).to have_http_status(:ok)
      user_data = JSON.parse(response.body)
      expect(user_data["id"]).to eq(admin_user.id)
      expect(user_data["email"]).to eq(admin_user.email)
    end

    it "fails authorization if the user is not authorized" do
      allow(controller).to receive(:authorize).and_raise(Pundit::NotAuthorizedError)
      get :show, params: { id: admin_user.id }
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "PATCH #update" do
    context "with valid parameters" do
      it "updates the user's information" do
        patch :update, params: valid_update_params
        expect(response).to have_http_status(:ok)
        admin_user.reload
        expect(admin_user.email).to eq("new_admin@quequeo.com")
      end
    end

    context "with invalid parameters" do
      it "does not update the user and returns errors" do
        patch :update, params: invalid_update_params
        expect(response).to have_http_status(:unprocessable_entity)
        errors = JSON.parse(response.body)
        expect(errors).not_to be_empty
      end
    end
  end

  describe "PATCH #avatar" do
    let(:valid_avatar) { fixture_file_upload(Rails.root.join("spec/fixtures/files/avatar.png"), "image/png") }

    it "updates the user's avatar with a valid file" do
      patch :avatar, params: { id: admin_user.id, avatar: valid_avatar }
      expect(response).to have_http_status(:ok)
      admin_user.reload
      expect(admin_user.avatar.attached?).to be true
    end

    it "returns unprocessable entity if avatar update fails" do
      allow(admin_user).to receive(:update).and_return(false)
      patch :avatar, params: { id: admin_user.id, avatar: valid_avatar }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
