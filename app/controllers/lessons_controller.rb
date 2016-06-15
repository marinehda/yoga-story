class LessonsController < ApplicationController
  before_action :set_lesson, only: [:show, :edit, :update]
  after_action :verify_authorized

  def index
    @lessons = policy_scope(Lesson)
  end

  def show
  end

  def new
    @lesson = Lesson.new
    authorize @lesson
  end

  def create
    @lesson = Teacher.find_by_id(current_user).lessons.build(lesson_params)
    authorize @lesson
    if @lesson.save
      redirect_to @lesson
    else
      flash[:alert] = t('.flash_alert')
    end
  end

  def edit
  end

  def update
    if @lesson.update(lesson_params)
      redirect_to lesson_path
    else
      flash[:alert] = t('.flash_alert')
    end
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
