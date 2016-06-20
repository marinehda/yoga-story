class LessonPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def my_index?
    record.teacher == user
  end

  def show?
    true
  end

  def create?
    record.teacher == user
  end

  def update?
    record.teacher == user
  end

  def cancel?
    record.teacher == user
  end

end
