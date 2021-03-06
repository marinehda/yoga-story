class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :cancel]

  after_action :verify_authorized, except: [:my_student_index, :my_teacher_index]
  after_action :verify_policy_scoped, only: [:my_teacher_index, :my_student_index]

  def my_student_index
    @bookings = policy_scope(Booking).bookings
    @future_bookings = []
    @past_bookings =[]
    @bookings.each do |booking|
      if booking.lesson.start_date >= DateTime.now
        @future_bookings << booking
      else
        @past_bookings << booking
      end
    end
    @future_bookings = @future_bookings.sort_by {|obj| obj.lesson.start_date}
    @past_bookings = @past_bookings.sort_by {|obj| obj.lesson.start_date}
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
      @booking.lesson_sku = @lesson.sku
      @booking.update_attributes(lesson_sku: @lesson.sku, amount: @lesson.price, payment_state: 'pending')
      if @booking.save
        # LessonMailer.booking_confirmation(@booking).deliver_now
        redirect_to new_booking_payment_path(@booking)
      else
        flash[:alert] = t('.flash_alert_not_saved')
      end
    else
      flash[:alert] = t('.flash_alert_full')
      redirect_to lessons_path
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

      Stripe.api_key = ENV['STRIPE_SECRET_KEY']
      refund = Stripe::Charge.retrieve(@booking.payment['id'])
      refund.refunds.create(:amount => @booking.payment['amount'])

      #update booking.payment
      @booking.update(payment: refund.to_json, payment_state: 'refunded')
      @booking.update_attribute(:status, 'cancelled')
      redirect_to my_student_index_bookings_path
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
