require 'rails_helper'

RSpec.describe ProjectPolicy do
  let(:admin) { create(:user, roles: [create(:role, name: 'admin')]) }
  let(:regular_user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:project) { create(:project, user: regular_user) }

  subject { described_class }

  describe "#index?" do
    it "allows any authenticated user to view projects" do
      policy = subject.new(regular_user, Project)
      expect(policy.index?).to be true
    end

    it "denies access for unauthenticated users" do
      policy = subject.new(nil, Project)
      expect(policy.index?).to be false
    end
  end

  describe "#show?" do
    it "allows a user to view their own project" do
      policy = subject.new(regular_user, project)
      expect(policy.show?).to be true
    end

    it "denies a user access to another user's project" do
      policy = subject.new(other_user, project)
      expect(policy.show?).to be false
    end

    it "allows an admin to view any project" do
      policy = subject.new(admin, project)
      expect(policy.show?).to be true
    end
  end

  describe "#create?" do
    it "allows an admin to create a project" do
      policy = subject.new(admin, Project.new)
      expect(policy.create?).to be true
    end

    it "denies regular users the ability to create a project" do
      policy = subject.new(regular_user, Project.new)
      expect(policy.create?).to be false
    end
  end

  describe "#update?" do
    it "allows a user to update their own project" do
      policy = subject.new(regular_user, project)
      expect(policy.update?).to be true
    end

    it "denies a user access to update another user's project" do
      policy = subject.new(other_user, project)
      expect(policy.update?).to be false
    end

    it "allows an admin to update any project" do
      policy = subject.new(admin, project)
      expect(policy.update?).to be true
    end
  end

  describe "#destroy?" do
    it "allows an admin to destroy any project" do
      policy = subject.new(admin, project)
      expect(policy.destroy?).to be true
    end

    it "denies regular users the ability to destroy projects" do
      policy = subject.new(regular_user, project)
      expect(policy.destroy?).to be false
    end
  end
end
