class UserPolicy < ApplicationPolicy
  def show?
    user.present? && (record == user || user.has_role?('admin'))
  end

  def update?
    user.present? && (record == user || user.has_role?('admin'))
  end

  def avatar?
    user.present? && (record == user || user.has_role?('admin'))
  end
end
