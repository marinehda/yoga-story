class TeacherPolicy < UserPolicy

  def new?
    user.id == record.id
  end

  def update?
    record.id == user.id
  end

  def show?
    true
  end

end
