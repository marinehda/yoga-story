class Lesson < ActiveRecord::Base
  belongs_to :teacher, class_name: 'User', foreign_key: 'teacher_id'
  has_many :bookings
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  validates_presence_of :start_date, :hours, :min_students, :max_students, :price, :name, :description, :address
  monetize :price_cents
end
