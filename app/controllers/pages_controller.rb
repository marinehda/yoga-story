class PagesController < ApplicationController
  include Pundit
  after_action :verify_authorized, except: [:home]

  def home
  end
end
