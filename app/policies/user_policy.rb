class UserPolicy < ApplicationPolicy

  # Inherited from ApplicationPolicy:
  # def initialize(user, record)
      # @user = user
      # @record = record
  # end

  def update?
      user == record
  end
end
