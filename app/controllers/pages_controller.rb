class PagesController < ApplicationController
  # Disable devise
  skip_before_action :authenticate_user!
  # Disable Pundit
  skip_after_action :verify_authorized

  def home
    @lessons = Lesson.all
  end

  def lessons
    @lessons = Lesson.all
   if params[:address].present?
     @lessons = @lessons.near(params[:address], 3)
   end
   if params[:start_date].present?
     @lessons = @lessons.where(start_date: params[:start_date].to_date.beginning_of_day..params[:start_date].to_date.end_of_day)
   end
   if @lessons == []
     @markers = Gmaps4rails.build_markers(Lesson.all) do |lesson, marker|
       marker.lat lesson.latitude
       marker.lng lesson.longitude
     end
   else
     @markers = Gmaps4rails.build_markers(@lessons) do |lesson, marker|
       marker.lat lesson.latitude
       marker.lng lesson.longitude
     end

   end
 end

 def teachers
   @teachers = User.where(type: 'Teacher')
 end
end
