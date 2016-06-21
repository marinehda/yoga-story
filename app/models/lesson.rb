class Lesson < ActiveRecord::Base
  belongs_to :teacher, class_name: 'User', foreign_key: 'teacher_id'
  has_many :bookings
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  validates_presence_of :start_date, :hours, :min_students, :max_students, :price, :name, :description, :address
  monetize :price_cents
  validate :start_date_in_future

  def start_date_in_future
    if self.start_date < DateTime.now
      errors.add(:start_date, "Start date should be before end date")
    end
  end
end
