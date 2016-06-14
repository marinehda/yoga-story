class Teacher < User
  belongs_to :user
  has_many :lessons
  has_attachments :photos, maximum: 3
end
