class AddDetailsToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :payment_state, :string
    add_column :bookings, :lesson_sku, :string
    add_monetize :bookings, :amount, currency: { present: false }
    add_column :bookings, :payment, :json
  end
end
