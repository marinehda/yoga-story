class LessonsController < ApplicationController
  before_action :set_lesson, only: [:show, :edit, :update, :cancel]
  after_action :verify_authorized, except: [:show]

  def index
    @lessons = policy_scope(Lesson)
  end

  def show
    @booking = current_user.bookings.new
    authorize @booking
    @message = current_user.messages.new
    authorize @message
    @marker = Gmaps4rails.build_markers(@lesson) do |lesson, marker|
      marker.lat lesson.latitude
      marker.lng lesson.longitude
      marker.infowindow lesson.name
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
      redirect_to lessons_teacher_path(current_user)
    else
      flash[:alert] = t('.flash_alert')
      render :new
    end
  end

  def edit
  end

  def update
    if params[:lesson][:start_date] != "" && @lesson.update(lesson_params)
      @lesson.update_attribute(:status, 'confirmed')
      redirect_to lessons_teacher_path(current_user)
    else
      flash[:alert] = t('.flash_alert')
      render :edit
    end
  end

  def cancel
    @lesson.update_attribute(:status, 'cancelled')
    redirect_to lessons_teacher_path(current_user)
  end

  private

  def set_lesson
    @lesson = Lesson.find(params[:id])
    authorize @lesson
  end

  def lesson_params
    parameters = params.require(:lesson).permit(:name, :start_date, :hours, :minutes, :address, :street_number, :street, :city, :zip_code, :min_students, :max_students, :description, :price, :location_name)
    if /PM/.match(parameters[:start_date])
      to_add = 12.0
    else
      to_add = 0
    end
    parameters[:start_date] =  DateTime.strptime(parameters[:start_date], "%m/%d/%Y %H:%M") + (to_add / 24) - (2.0 / 24)
    parameters
  end

end
