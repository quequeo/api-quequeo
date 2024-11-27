require "rails_helper"

RSpec.describe User, type: :model do
  it "is invalid without an email" do
    user = User.new(email: nil)
    expect(user).not_to be_valid
  end
end
