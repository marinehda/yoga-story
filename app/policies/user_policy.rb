class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    record.id == user.id or user.is_admin?
  end

  def update?
      user == record
  end
end
