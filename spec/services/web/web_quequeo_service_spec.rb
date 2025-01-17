require 'rails_helper'

RSpec.describe Web::QuequeoService do
  describe '.call' do
    it 'returns content in Spanish when language is "es"' do
      result = Web::QuequeoService.call[:es]

      expect(result[:page_title]).to eq('Sitio Web Quequeo')
      expect(result[:title]).to eq('React, Ruby on Rails, AWS y más')
    end

    it 'returns content in English when language is "en"' do
      result = Web::QuequeoService.call[:en]

      expect(result[:page_title]).to eq('Quequeo Website')
      expect(result[:title]).to eq('React, Ruby on Rails, AWS and more')
    end
  end
end
