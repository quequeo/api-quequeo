require 'rails_helper'

RSpec.describe Api::Web::AboutMeController, type: :controller do
  describe 'GET #content' do
    let(:secret_key) { ENV['WEB_QUEQUEO_SECRET_KEY'] }

    before do
      allow(Web::AboutMeService).to receive(:call).and_return({
        en: {
          page_title: 'About Me'
        },
        es: {
          page_title: 'Sobre Mí'
        }
      })
    end

    it 'returns the content in JSON format with status :ok' do
      request.headers['X-Secret-Key'] = secret_key
      get :content

      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response['en']['page_title']).to eq('About Me')
      expect(json_response['es']['page_title']).to eq('Sobre Mí')
    end
  end
end
