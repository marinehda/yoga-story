class BookingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      user
    end
  end

  def show?
    # only booking user or teacher can see a booking show view
    record.user == user || record.lesson.teacher_id == user.id
  end

  def create?
    record.user == user
  end

  def update?
    record.user == user
  end

  def cancel?
    record.teacher == user
  end
end
