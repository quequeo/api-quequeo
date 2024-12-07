require 'rails_helper'

RSpec.describe Role, type: :model do
  it "is valid with a name" do
    role = build(:role, name: "admin")
    expect(role).to be_valid
  end

  it "is invalid without a name" do
    role = build(:role, name: nil)
    expect(role).not_to be_valid
  end
end
