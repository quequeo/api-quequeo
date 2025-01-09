require 'rails_helper'

RSpec.describe Resume, type: :model do
  # Associations
  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:work_experiences).dependent(:destroy) }
  it { is_expected.to have_many(:personal_informations).dependent(:destroy) }
  it { is_expected.to accept_nested_attributes_for(:work_experiences).allow_destroy(true) }
  it { is_expected.to accept_nested_attributes_for(:personal_informations).allow_destroy(true) }

  # Validations
  it { is_expected.to validate_presence_of(:style) }
  it { is_expected.to validate_inclusion_of(:style).in_array(Resume::STYLES.keys.map(&:to_s)) }

  # Context for styles
  context "styles" do
    it "is invalid with an invalid style" do
      resume = FactoryBot.build(:resume, style: "invalid")
      expect(resume).not_to be_valid
      expect(resume.errors[:style]).to include("is not included in the list")
    end

    it "is valid with a valid style" do
      Resume::STYLES.keys.each do |valid_style|
        resume = FactoryBot.build(:resume, style: valid_style)
        expect(resume).to be_valid
      end
    end
  end
end
