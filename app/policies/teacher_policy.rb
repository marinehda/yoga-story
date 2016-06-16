class TeacherPolicy < UserPolicy
  # class Scope < Scope
  #   def resolve
  #     scope.all
  #   end
  # end
  #
  def new?
    user == record
  end

  def update?
    record == user
  end
  #
  # def show?
  #   (record.id == user.id or user.is_admin?) && user.teacher?
  # end
  #
  # def create
  #   user == record && not user.teacher?
  # end
  #
  # def update?
  #   user == record && user.teacher?
  # end

end
