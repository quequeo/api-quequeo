require 'rails_helper'

RSpec.describe UserPolicy do
  let(:admin) { create(:user, roles: [create(:role, name: 'admin')]) }
  let(:regular_user) { create(:user) }
  let(:other_user) { create(:user) }

  subject { described_class }

  describe "#show?" do
    it "allows users to view their own profile" do
      policy = subject.new(regular_user, regular_user)
      expect(policy.show?).to be true
    end

    it "prevents users from viewing another user's profile" do
      policy = subject.new(regular_user, other_user)
      expect(policy.show?).to be false
    end

    it "allows admins to view any user's profile" do
      policy = subject.new(admin, other_user)
      expect(policy.show?).to be true
    end
  end

  describe "#update?" do
    it "allows users to update their own profile" do
      policy = subject.new(regular_user, regular_user)
      expect(policy.update?).to be true
    end

    it "prevents users from updating another user's profile" do
      policy = subject.new(regular_user, other_user)
      expect(policy.update?).to be false
    end

    it "allows admins to update any user's profile" do
      policy = subject.new(admin, other_user)
      expect(policy.update?).to be true
    end
  end

  describe "#avatar?" do
    it "allows users to update their own avatar" do
      policy = subject.new(regular_user, regular_user)
      expect(policy.avatar?).to be true
    end

    it "prevents users from updating another user's avatar" do
      policy = subject.new(regular_user, other_user)
      expect(policy.avatar?).to be false
    end

    it "allows admins to update any user's avatar" do
      policy = subject.new(admin, other_user)
      expect(policy.avatar?).to be true
    end
  end
end
