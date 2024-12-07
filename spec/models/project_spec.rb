require 'rails_helper'

RSpec.describe Project, type: :model do
  it "is valid with valid attributes" do
    project = build(:project)
    expect(project).to be_valid
  end

  it "belongs to a user" do
    user = create(:user)
    project = create(:project, user: user)
    expect(project.user).to eq(user)
  end
end
