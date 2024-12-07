require 'rails_helper'

RSpec.describe UserRole, type: :model do
  it "is valid with valid attributes" do
    user_role = build(:user_role)
    expect(user_role).to be_valid
  end

  it "is invalid with a duplicate user and role combination" do
    user = create(:user)
    role = create(:role)
    create(:user_role, user: user, role: role)
    duplicate_user_role = build(:user_role, user: user, role: role)
    expect(duplicate_user_role).not_to be_valid
  end

  it "belongs to a user" do
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

  it "belongs to a role" do
    user = create(:user)
    role = create(:role, name: "admin")
    user_role = create(:user_role, user: user, role: role)
    expect(user_role.role).to eq(role)
  end
end
