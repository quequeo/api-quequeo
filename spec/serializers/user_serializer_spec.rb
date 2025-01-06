require 'rails_helper'

RSpec.describe UserSerializer, type: :serializer do
  let(:user) { create(:user) }
  let(:serialized_user) { described_class.new(user).as_json }

  it 'includes id, email, and avatar_url' do
    expect(serialized_user).to include(:id, :email, :avatar_url)
  end

  it 'returns a nil avatar_url if no avatar is attached' do
    expect(serialized_user[:avatar_url]).to be_nil
  end

  it 'returns a valid avatar_url if an avatar is attached' do
    user.avatar.attach(io: File.open(Rails.root.join('spec/fixtures/files/avatar.png')), filename: 'avatar.png')
    expect(serialized_user[:avatar_url]).to be_present
  end
end
