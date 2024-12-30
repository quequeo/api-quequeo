require 'rails_helper'

RSpec.describe Web::AboutMeService do
  describe '.call' do
    it 'returns content in Spanish when language is "es"' do
      result = Web::AboutMeService.call[:es]

      expect(result[:page_title]).to eq('Sobre mí')
      expect(result[:title]).to eq('Jaime García Méndez')
    end

    it 'returns content in English when language is "en"' do
      result = Web::AboutMeService.call[:en]

      expect(result[:page_title]).to eq('About me')
    end
  end
end
