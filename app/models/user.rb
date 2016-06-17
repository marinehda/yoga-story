class User < ActiveRecord::Base
  has_many :bookings
  
  after_create :send_welcome_email

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  mount_uploader :photo, PhotoUploader
  #
  # validate :birth_date_cannot_be_in_the_future
  #
  # def birth_date_cannot_be_in_the_future
  #   if birth_date.present? && birth_date > Date.today
  #     # errors.add(:birth_date, "can't be in the future")
  #     flash[:alert] = t('.flash_alert')
  #   end
  # end

  def teacher?
    type == 'Teacher'
  end

  def set_as_teacher
    self.type = 'Teacher'
    save
  end

  def set_as_user
    self.type = nil
  end

  def self.find_for_facebook_oauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]  # Fake password for validation
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.photo = auth.info.image
      user.token = auth.credentials.token
      user.token_expiry = Time.at(auth.credentials.expires_at)
    end
  end

  private

  def send_welcome_email
    UserMailer.welcome(self).deliver_now
  end

end
