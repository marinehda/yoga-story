class TeacherPolicy < ApplicationPolicy
  attr_reader :user, :teacher

  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def initialize(user, post)
    @user = user
    @teacher = teacher
  end

  def authorized?
    record.user == user or user.is_admin?
  end

  def new?
    create?
  end

  def create?
    user.present?
  end

  def update?
    record.user == user or user.admin?
  end
end
