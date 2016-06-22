class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :recipient, class_name: 'User'

  def user_status(current_user)
    return false unless (user_id == current_user.id) || (recipient_id == current_user.id)
    user_id == current_user.id ? :sender : :recipient
  end
end
