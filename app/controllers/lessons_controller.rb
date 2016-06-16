class LessonsController < ApplicationController
  before_action :set_lesson, only: [:show, :edit, :update]
  after_action :verify_authorized

  def index
    @lessons = Lesson.all
    @lessons = policy_scope(Lesson)
  end

  def my_index
    @lessons = Teacher.find(params[:id]).lessons
    @lessons.each do |lesson|
      authorize lesson
    end
  end

  def show
    @lesson = Lesson.find(params[:id])
    authorize @lesson
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
      redirect_to lesson_path(@lesson)
    else
      flash[:alert] = t('.flash_alert')
    end
  end

  def edit
  end

  def update
  end

  private

  def set_lesson
  end

  def lesson_params
    params.require(:lesson).permit(:name, :start_date, :end_date, :address, :street_number, :street, :city, :zip_code, :min_students, :max_students, :description, :price, :location_name)
  end

end
