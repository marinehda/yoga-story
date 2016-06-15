class TeacherPolicy < ApplicationPolicy

  def show?
    user.teacher?
  end
  
end
