require 'rails_helper'

RSpec.describe Api::Web::WorkExperienceController, type: :controller do
  describe 'GET #content' do
    let(:secret_key) { ENV['WEB_QUEQUEO_SECRET_KEY'] }

    before do
      allow(Web::WorkExperienceService).to receive(:call).and_return({
        en: {
          page_title: 'Work Experience'
        },
        es: {
          page_title: 'Experiencia Laboral'
        }
      })
    end

    it 'returns the content in JSON format with status :ok' do
      request.headers['X-Secret-Key'] = secret_key
      get :content

      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response['en']['page_title']).to eq('Work Experience')
      expect(json_response['es']['page_title']).to eq('Experiencia Laboral')
    end
  end
end
