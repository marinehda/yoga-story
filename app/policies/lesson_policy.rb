class LessonPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def my_index?
    record.teacher == user
  end

  def show?
    true
  end

  def create?
    user.teacher? && record.teacher == user
  end

  def edit
    update?
  end

  def update?
    lesson.teacher_id == user.id && user.teacher?
  end

end
