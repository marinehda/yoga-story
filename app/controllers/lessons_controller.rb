class LessonsController < ApplicationController
  before_action :set_lesson, only: [:show, :edit, :update, :cancel]
  after_action :verify_authorized

  def index
    @lessons = policy_scope(Lesson)
  end

  def my_index
    @lessons = Teacher.find(params[:id]).lessons
    if @lessons == []
      authorize Teacher.find(params[:id]).lessons.new
    else
      @lessons.each { |i| authorize i, :my_index? }
    end
  end

  def show
    @marker = Gmaps4rails.build_markers(@lesson) do |lesson, marker|
      marker.lat lesson.latitude
      marker.lng lesson.longitude
    end
  end

  def new
    @lesson = current_user.lessons.new
    authorize @lesson
  end

  def create
    @teacher = current_user
    @lesson = @teacher.lessons.build(lesson_params)
    authorize @lesson
    if @lesson.save
      LessonMailer.creation_confirmation(@lesson).deliver_now
      redirect_to my_lessons_teacher_path(current_user)
    else
      flash[:alert] = t('.flash_alert')
    end
  end

  def edit
  end

  def update
    if @lesson.update(lesson_params)
      redirect_to my_lessons_teacher_path(current_user)
    else
      flash[:alert] = t('.flash_alert')
    end
  end

  def cancel
    @lesson.update_attribute(:status, "cancelled")
    redirect_to my_lessons_teacher_path(current_user)
  end

  private

  def set_lesson
    @lesson = Lesson.find(params[:id])
    authorize @lesson
  end

  def lesson_params
    params.require(:lesson).permit(:name, :start_date, :end_date, :address, :street_number, :street, :city, :zip_code, :min_students, :max_students, :description, :price, :location_name)
  end

end
