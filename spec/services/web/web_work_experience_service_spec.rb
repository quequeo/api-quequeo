require 'rails_helper'

RSpec.describe Web::WorkExperienceService do
  describe '.call' do
    it 'returns content in Spanish when language is "es"' do
      result = Web::WorkExperienceService.call[:es]

      expect(result[:page_title]).to eq('Experiencia Laboral')
    end

    it 'returns content in English when language is "en"' do
      result = Web::WorkExperienceService.call[:en]

      expect(result[:page_title]).to eq('Work Experience')
    end
  end
end
