class LessonPolicy < ApplicationPolicy
  attr_reader :user, :lesson

  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def initialize(user, lesson)
    @user = user
    @lesson = lesson
  end

  def show?
    true
  end

  def create?
    user.teacher?
  end

  def update?
    record.user == user && user.teacher?
  end


end
