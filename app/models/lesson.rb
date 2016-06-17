class Lesson < ActiveRecord::Base
  belongs_to :teacher, class_name: 'User', foreign_key: 'teacher_id'

  geocoded_by :address
  after_validation :geocode, if: :address_changed?
end
