class ResumePolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    user == record.user
  end

  def create?
    true
  end

  def update?
    user == record.user
  end

  def destroy?
    user == record.user
  end
end
