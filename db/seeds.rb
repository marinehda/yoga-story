require 'faker'

# Run using rake db:reset rather than rake db:seed to not break ids logic in this file
# When modifying validators in model, amend this file

User.delete_all
Lesson.delete_all

(1..10).each do |i|
  user = User.new(
    email: 'user' + i.to_s + '@yogastory.com',
    password: 'aaaaaa'
    )
  user.save!
  p 'user' + i.to_s
end

user1 = User.first
user1.is_admin = true
user1.save

(11..15).each do |i|
  user = User.new(
    email: 'user' + i.to_s + '@yogastory.com',
    password: 'aaaaaa',
    type: 'Teacher'
    )
  user.save!
  p 'teacher' + i.to_s
end

(1..20).each do |i|
  lesson = Lesson.new(
    name: 'lesson' + i.to_s,
    teacher_id: (11..15).to_a.sample,
    start_date: Faker::Time.forward(30, :morning) 
    )
  lesson.save!
  p 'lesson' + i.to_s
end
