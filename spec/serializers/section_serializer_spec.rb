require 'rails_helper'

RSpec.describe SectionSerializer, type: :serializer do
  let(:resume) { create(:resume) }
  let(:section) { create(:section, resume: resume) }
  let(:serializer) { described_class.new(section) }
  let(:serialization) { ActiveModelSerializers::Adapter.create(serializer) }

  it 'serializes the attributes correctly' do
    expected_json = {
      id: section.id,
      title: section.title,
      content: section.content,
      created_at: section.created_at,
      updated_at: section.updated_at,
      resume: {
        id: resume.id,
        title: resume.title,
        style: resume.style,
        created_at: resume.created_at,
        updated_at: resume.updated_at
      }
    }

    expect(serialization.as_json).to eq(expected_json)
  end
end
