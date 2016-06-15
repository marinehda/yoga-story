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

  def edit
    update?
  end

  def update?
    lesson.teacher_id == user.id && user.teacher?
  end

end
