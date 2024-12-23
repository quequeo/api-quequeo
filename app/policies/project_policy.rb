class ProjectPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def show?
    user.present? && (record.user == user || user.has_role?('admin'))
  end

  def create?
    user.present? && user.has_role?('admin')
  end

  def update?
    user.present? && (record.user == user || user.has_role?('admin'))
  end

  def destroy?
    user.present? && user.has_role?('admin')
  end
end
