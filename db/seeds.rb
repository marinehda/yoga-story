require 'faker'

# Run using rake db:reset rather than rake db:seed to not break ids logic in this file
# When modifying validators in model, amend this file

Booking.delete_all
Lesson.delete_all
User.delete_all

yoga_type = [['Ashtanga Vinyasa Yoga'], ['Iyengar Yoga'], ['Vinyasa Yoga'], ['Hatha Yoga'], ['Yoga Chamanique'], ['Yin Yoga'], ['Pranayama (respiration)']]

(1..10).each do |i|
  user = User.new(
    email: 'user' + i.to_s + '@yogastory.com',
    password: 'aaaaaa',
    #yoga_type: yoga_type.sample
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
    type: 'Teacher',
    yoga_type: yoga_type.sample,
    experience: (1970..2015).to_a.sample,
    description: Faker::Lorem.sentence
    )
  user.save!
  p 'teacher' + i.to_s
end

address_list = ["rue de l'Abbé Aerts","rue de l'Abbé Bonpain","rue de l'Abbé Cousin","rue Abélard","rue d'Aboukir","rue Adolphe","rue Adolphe Casse","avenue Adolphe Max","rue de l'Amidonnerie","rue d'Angleterre","rue Arago","rue de l'Arc","rue des Archives","rue d'Arras","rue d'Artois","rue des Arts","rue de la Baignerie","rue de Bailleul","rue de la Barre","rue Barthélémy-Delespaul","rue Basse","rue du Bastion-du-Meunier","rue Bartholomé-Masurel","rue Baudon","rue Beaucourt-Decourchelle","rue Benvignat","rue de Béthune","boulevard Bigo-Danel","place aux Bleuets","rue des Bonnes-Rappes","rue des Bons-Enfants","rue Boucher-de-Perthes","rue des Bouchers","rue de la Bourse","rue Brûle-Maison du surnom du chansonnier François Cottignies","rue de Bruxelles","rue des Canonniers","boulevard Carnot","rue des Célestines","rue de la Chambre-des-Comptes","rue des Chats-Bossus","rue Charles-le-Quint","rue du Cirque","rue de Courtrai","rue à Claques","rue de la Clef","rue Comtesse","rue Colas","rue de la Collégiale","place du Concert","rue Coquerez","rue du Curé-Saint-Étienne","square Daubenton","rue des Débris-Saint-Étienne","rue des Deux Épées","rue Doudin","square Dutilleul"]

photos = ['http://res.cloudinary.com/dj8owx8ry/image/upload/c_scale,w_275/v1466591298/Photo%20cours/cours19.jpg','http://res.cloudinary.com/dj8owx8ry/image/upload/c_scale,w_275/v1466591276/Photo%20cours/cours20.jpg','http://res.cloudinary.com/dj8owx8ry/image/upload/c_scale,w_275/v1466590530/Photo%20cours/cours1.jpg','http://res.cloudinary.com/dj8owx8ry/image/upload/c_scale,w_275/v1466590530/Photo%20cours/cours17.jpg','http://res.cloudinary.com/dj8owx8ry/image/upload/c_scale,w_275/v1466590530/Photo%20cours/cours6.jpg','http://res.cloudinary.com/dj8owx8ry/image/upload/c_scale,w_275/v1466590530/Photo%20cours/cours7.jpg','http://res.cloudinary.com/dj8owx8ry/image/upload/c_scale,w_275/v1466590530/Photo%20cours/cours2.jpg','http://res.cloudinary.com/dj8owx8ry/image/upload/c_scale,w_275/v1466590530/Photo%20cours/cours5.jpg','http://res.cloudinary.com/dj8owx8ry/image/upload/c_scale,w_275/v1466590530/Photo%20cours/cours4.jpg','http://res.cloudinary.com/dj8owx8ry/image/upload/c_scale,w_275/v1466590530/Photo%20cours/cours3.jpg','http://res.cloudinary.com/dj8owx8ry/image/upload/c_scale,w_275/v1466181840/Photo%20cours/cours8.jpg','http://res.cloudinary.com/dj8owx8ry/image/upload/c_scale,w_275/v1466181813/Photo%20cours/cours9.jpg','http://res.cloudinary.com/dj8owx8ry/image/upload/c_scale,w_275/v1466181789/Photo%20cours/cours10.jpg','http://res.cloudinary.com/dj8owx8ry/image/upload/c_scale,w_275/v1466181769/Photo%20cours/cours11.jpg','http://res.cloudinary.com/dj8owx8ry/image/upload/c_scale,w_275/v1466181753/Photo%20cours/cours12.jpg','http://res.cloudinary.com/dj8owx8ry/image/upload/c_scale,w_275/v1466181691/Photo%20cours/cours13.jpg','http://res.cloudinary.com/dj8owx8ry/image/upload/c_scale,w_275/v1466181681/Photo%20cours/cours18.jpg','http://res.cloudinary.com/dj8owx8ry/image/upload/c_scale,w_275/v1466017414/Photo%20cours/cours14.jpg','http://res.cloudinary.com/dj8owx8ry/image/upload/c_scale,w_275/v1465905324/Photo%20cours/cours15.jpg','http://res.cloudinary.com/dj8owx8ry/image/upload/c_scale,w_275/v1465905315/Photo%20cours/cours16.jpg']

(1..20).each do |i|
  lesson = Lesson.new(
    name: 'lesson' + i.to_s,
    description: Faker::Lorem.sentence,
    teacher_id: User.where(type: 'Teacher').sample.id,
    start_date: Faker::Date.between(Date.today, 1.month.from_now),
    hours: [1, 2, 3, 4].sample,
    minutes: [0, 15, 30, 45].sample,
    price: (10..40).to_a.sample,
    min_students: 1,
    max_students: 4,
    address: (1..10).to_a.sample.to_s + ' ' + address_list.sample + ', Lille'
    )
  lesson.valid?
  lesson.update_attribute(:start_date, Faker::Date.between(1.month.ago, 1.month.from_now))
  lesson.remote_photo_url = photos.sample
  lesson.save(validate: false)
  p 'lesson' + i.to_s
end

(1..50).each do |i|
  booking = Booking.new(
  user_id: User.all.sample,
  #lesson_id: (1..20).to_a.sample,
  status: 'confirmed'
  )
  #find a lesson with availability
  while booking.lesson_id == nil do
    lesson_id = Lesson.all.sample.id
    if Lesson.find(lesson_id).bookings.count < Lesson.find(lesson_id).max_students
      booking.lesson_id = lesson_id
    end
  end

  if booking.lesson.start_date < DateTime.now
    booking.update_attributes(review_rating: (0..5).to_a.sample, review_content: Faker::Lorem.sentence, amount_cents: booking.lesson.price_cents)
  else
    booking.amount_cents = booking.lesson.price_cents
  end
  booking.save!
  p 'booking' + i.to_s
end
