require 'rails_helper'

RSpec.describe Section, type: :model do
  describe 'associations' do
    it { should belong_to(:resume) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:content) }
  end

  describe 'factory' do
    it 'has a valid factory' do
      section = build(:section)
      expect(section).to be_valid
    end
  end
end
