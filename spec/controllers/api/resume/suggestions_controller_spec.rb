require 'rails_helper'

RSpec.describe Api::Resume::V1::SuggestionsController, type: :controller do
  let(:valid_content) { "This is a sample resume content" }
  let(:invalid_content) { nil }
  let(:mock_response) { "Suggested improvement for the content" }
  let(:mock_error_response) { "Error processing the request" }

  before do
    allow(controller).to receive(:current_user).and_return(create(:user))
  end

  describe "POST #create" do
    context "with valid content" do
      it "returns suggestions from OpenAiService" do
        allow_any_instance_of(Resume::OpenAiService).to receive(:suggest_improvements).and_return(mock_response)

        post :create, params: { content: valid_content }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["suggestions"]).to eq(mock_response)
      end
    end

    context "with blank content" do
      it "returns a bad request error" do
        post :create, params: { content: invalid_content }

        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)["error"]).to eq("Content cannot be blank")
      end
    end

    context "when OpenAiService returns an error" do
      it "returns an internal server error" do
        allow_any_instance_of(Resume::OpenAiService).to receive(:suggest_improvements).and_return(mock_error_response)

        post :create, params: { content: valid_content }

        expect(response).to have_http_status(:internal_server_error)
        expect(JSON.parse(response.body)["error"]).to eq(mock_error_response)
      end
    end
  end
end
