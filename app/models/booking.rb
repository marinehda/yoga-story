class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :lesson
  monetize :amount_cents
end
