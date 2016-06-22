class MessagePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where('recipient_id = :user_id OR user_id = :user_id', user_id: user.id)
    end
  end

  def list?
    true
  end

  def create?
    record.user == user
  end
end
