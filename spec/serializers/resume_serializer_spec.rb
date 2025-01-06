require 'rails_helper'

RSpec.describe ResumeSerializer, type: :serializer do
  let(:user) { create(:user) }
  let(:resume) { create(:resume, user: user) }
  let!(:section1) { create(:section, resume: resume) }
  let!(:section2) { create(:section, resume: resume) }
  let(:serializer) { described_class.new(resume) }
  let(:serialization) { ActiveModelSerializers::Adapter.create(serializer) }

  it 'serializes the attributes correctly' do
    expected_json = {
      id: resume.id,
      title: resume.title,
      style: resume.style,
      created_at: resume.created_at,
      updated_at: resume.updated_at,
      user: {
        id: user.id,
        email: user.email,
        avatar_url: user.send(:avatar_url)
      },
      sections: [
        {
          id: section1.id,
          title: section1.title,
          content: section1.content,
          created_at: section1.created_at,
          updated_at: section1.updated_at
        },
        {
          id: section2.id,
          title: section2.title,
          content: section2.content,
          created_at: section2.created_at,
          updated_at: section2.updated_at
        }
      ]
    }

    expect(serialization.as_json).to eq(expected_json)
  end
end
