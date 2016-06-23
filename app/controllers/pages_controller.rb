class PagesController < ApplicationController
  # Disable devise
  skip_before_action :authenticate_user!
  # Disable Pundit
  skip_after_action :verify_authorized

  def home
    @lessons = Lesson.all
  end

  def lessons
    @lessons = Lesson.where(status: 'confirmed').where('start_date >= ?', DateTime.now).order(:start_date)
    if params[:address].present?
     @lessons = @lessons.near(params[:address], 5)
    end
    if params[:start_date].present?
     @lessons = @lessons.where(start_date: params[:start_date].to_date.beginning_of_day..params[:start_date].to_date.end_of_day)
    end
    if @lessons == []
     @markers = Gmaps4rails.build_markers(Lesson.all.where(status: 'confirmed').where('start_date >= ?', DateTime.now)) do |lesson, marker|
       marker.lat lesson.latitude
       marker.lng lesson.longitude
       marker.infowindow lesson.start_date.to_date
     end
    else
     @markers = Gmaps4rails.build_markers(@lessons) do |lesson, marker|
       marker.lat lesson.latitude
       marker.lng lesson.longitude
       marker.infowindow lesson.start_date.to_date
     end
    end
   end

   def teachers
     @teachers = User.where(type: 'Teacher')
   end
end
