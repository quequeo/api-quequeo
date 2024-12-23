require 'rails_helper'

RSpec.describe ProjectSerializer, type: :serializer do
  let(:user) { create(:user) }
  let(:project) { create(:project, user: user) }
  let(:serialized_project) { described_class.new(project).as_json }

  it 'includes id, title, description, logo_url, and user_id' do
    expect(serialized_project).to include(:id, :title, :description, :logo_url, :user_id)
  end

  it 'returns a nil logo_url if no logo is attached' do
    expect(serialized_project[:logo_url]).to be_nil
  end

  it 'returns a valid logo_url if a logo is attached' do
    project.logo.attach(io: File.open(Rails.root.join('spec/fixtures/files/test_logo.png')), filename: 'test_logo.png')
    expect(serialized_project[:logo_url]).to be_present
  end
end
