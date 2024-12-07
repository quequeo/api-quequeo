require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with valid attributes" do
    user = build(:user)
    expect(user).to be_valid
  end

  it "is invalid without an email" do
    user = build(:user, email: nil)
    expect(user).not_to be_valid
  end

  it "is invalid with a duplicate email" do
    create(:user, email: "test@example.com")
    user = build(:user, email: "test@example.com")
    expect(user).not_to be_valid
  end

  it "responds to roles" do
    user = create(:user)
    role = create(:role, name: "admin")
    user.roles << role
    expect(user.roles).to include(role)
  end

  it "checks if a user has a specific role" do
    user = create(:user)
    role = create(:role, name: "admin")
    user.roles << role
    expect(user.has_role?("admin")).to be true
    expect(user.has_role?("guest")).to be false
  end
end
