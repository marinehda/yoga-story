class PaymentsController < ApplicationController
  before_action :set_booking

  def new
  end

  def create
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

  @booking.update(payment: charge.to_json, state: 'paid')
  redirect_to order_path(@booking)

  rescue Stripe::CardError => e
  flash[:error] = e.message
  redirect_to new_order_payment_path(@booking)
  end

  private

  def set_booking
    @booking = Booking.where(payment_state: 'pending').find(params[:booking_id])
  end
end
