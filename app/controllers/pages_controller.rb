class PagesController < ApplicationController
  # Disable devise
  skip_before_action :authenticate_user!
  # Disable Pundit
  skip_after_action :verify_authorized

  def home
    @disable_nav = true
  end

end
