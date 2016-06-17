class PagesController < ApplicationController
  # Disable devise
  skip_before_action :authenticate_user!
  # Disable Pundit
  skip_after_action :verify_authorized

  def home
    @disable_nav = true
    @lessons = Lesson.all
  end

  def lessons
    @lessons = Lesson.all
   if params[:address].present?
     @lessons = @lessons.near(params[:address], 10)
   end
   if params[:start_date].present?
     @lessons = @lessons.where(start_date: params[:start_date].to_date.beginning_of_day..params[:start_date].to_date.end_of_day)
   end
 end

end
