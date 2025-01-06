class SectionPolicy < ApplicationPolicy
  def create?
    user == record.resume.user
  end

  def update?
    user == record.resume.user
  end

  def destroy?
    user == record.resume.user
  end
end
