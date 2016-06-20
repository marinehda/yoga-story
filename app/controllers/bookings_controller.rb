class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :cancel]

  after_action :verify_authorized, except: [:my_student_index, :my_teacher_index]
  after_action :verify_policy_scoped, only: [:my_teacher_index, :my_student_index]

  def my_student_index
    @bookings = policy_scope(Booking).bookings
    respond_to do |format|
      format.html # my_student_index.html.erb
      format.js # my_student_index.js.erb
      format.json { render json: @bookings }
    end
  end

  def my_teacher_index
    @bookings = policy_scope(Booking).lessons.collect(&:bookings).flatten.uniq
  end

  def show
  end

  def create
    @lesson = Lesson.find(params[:lesson_id])
    @booking = current_user.bookings.build()
    authorize @booking
    if check_availability == true
      @booking.lesson = @lesson
      if @booking.save
        # LessonMailer.booking_confirmation(@booking).deliver_now
        redirect_to my_student_index_bookings_path
      else
        flash[:alert] = t('.flash_alert')
      end
    else
      flash[:alert] = t('.flash_alert') ##personnaliser => .flash_availability
    end
  end

  def edit
  end

  def update ##pas besoin sauf si on gère le nombre de place par booking
    if @booking.update(booking_params)
      redirect_to my_student_index_bookings_path
    else
      flash[:alert] = t('.flash_alert')
    end
  end

  def cancel
    if @booking.update_attribute(:status, 'cancelled')
      redirect_to my_student_index_bookings_path
    else
      flash[:alert] = t('.flash_alert')
    end
  end

  private

  def check_availability
    @lesson = Lesson.find(params[:lesson_id])
    @lesson.bookings.count < @lesson.max_students
  end

  def set_booking
    @booking = Booking.find(params[:id])
    authorize @booking
  end

  def booking_params
    params.require(:booking).permit(:review_content, :review_rating)
  end
end
