require 'rails_helper'

RSpec.describe Api::Web::QuequeoController, type: :controller do
  describe 'GET #content' do
    let(:secret_key) { ENV['WEB_QUEQUEO_SECRET_KEY'] }

    before do
      allow(Web::QuequeoService).to receive(:call).and_return({
        en: {
          page_title: 'Quequeo Website',
          title: 'ReactJS, Ruby on Rails & AWS'
        },
        es: {
          page_title: 'Sitio Web Quequeo',
          title: 'ReactJS, Ruby on Rails y AWS'
        }
      })
    end

    it 'returns the content in JSON format with status :ok' do
      request.headers['X-Secret-Key'] = secret_key
      get :content

      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response['en']['page_title']).to eq('Quequeo Website')
      expect(json_response['es']['page_title']).to eq('Sitio Web Quequeo')
    end
  end
end
