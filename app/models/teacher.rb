class Teacher < User
  belongs_to :user
  has_many :lessons
end
