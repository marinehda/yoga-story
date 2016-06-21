class PaymentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      user
    end
  end

  def create?
    record.booking.user == user
  end

end
