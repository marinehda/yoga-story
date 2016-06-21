class PaymentsController < ApplicationController
  before_action :set_booking
  after_action :verify_authorized

  def new
    authorize @booking
  end

  def create
    authorize @booking
    @amount_cents = @booking.amount_cents

    customer = Stripe::Customer.create(
      source: params[:stripeToken],
      email:  params[:stripeEmail]
    )

    charge = Stripe::Charge.create(
      customer:     customer.id,   # You should store this customer id and re-use it.
      amount:       @amount_cents, # in cents
      description:  "Payment for lesson #{@booking.lesson_sku} for booking #{@booking.id}",
      currency:     'eur'
    )

    @booking.update(payment: charge.to_json, payment_state: 'paid')
    redirect_to booking_path(@booking)

    rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_booking_payment_path(@booking)
  end

  def cancel
    #authorization
    authorize @booking

    #refund
    Stripe.api_key = STRIPE_SECRET_KEY
    refund = Stripe::Charge.retrieve(@booking.payment[:id])
    refund.refunds.create(:amount => @booking.payment[:amount])

    #update booking.payment
    @booking.update(payment: refund.to_json, payment_state: 'refunded')
    redirect_to booking_path(@booking)
  end

  private

  def set_booking
    @booking = Booking.where(payment_state: 'pending').find(params[:booking_id])
  end
end
