require 'faker'

# Run using rake db:reset rather than rake db:seed to not break ids logic in this file
# When modifying validators in model, amend this file

Booking.delete_all
Lesson.delete_all
User.delete_all

yoga_type = [['Ashtanga Vinyasa Yoga'], ['Iyengar Yoga'], ['Vinyasa Yoga'], ['Hatha Yoga'], ['Yoga Chamanique'], ['Yin Yoga'], ['Pranayama (respiration)']]
user_photos = ["http://res.cloudinary.com/dj8owx8ry/image/upload/v1466703983/te%CC%81le%CC%81chargement_kpwsfy.jpg","http://res.cloudinary.com/dj8owx8ry/image/upload/v1466703983/te%CC%81le%CC%81chargement_7_rtdu2f.jpg","http://res.cloudinary.com/dj8owx8ry/image/upload/v1466703983/te%CC%81le%CC%81chargement_6_aqr7j1.jpg","http://res.cloudinary.com/dj8owx8ry/image/upload/v1466703983/te%CC%81le%CC%81chargement_5_n1mlzh.jpg","http://res.cloudinary.com/dj8owx8ry/image/upload/v1466703983/te%CC%81le%CC%81chargement_4_glpeja.jpg","http://res.cloudinary.com/dj8owx8ry/image/upload/v1466703983/te%CC%81le%CC%81chargement_3_g1sstu.jpg","http://res.cloudinary.com/dj8owx8ry/image/upload/v1466703983/te%CC%81le%CC%81chargement_2_mbo3fh.jpg","http://res.cloudinary.com/dj8owx8ry/image/upload/v1466703983/te%CC%81le%CC%81chargement_1_bpxezj.jpg","http://res.cloudinary.com/dj8owx8ry/image/upload/v1466703983/images_hedi6s.jpg","http://res.cloudinary.com/dj8owx8ry/image/upload/v1466703982/images_6_qqspw5.jpg","http://res.cloudinary.com/dj8owx8ry/image/upload/v1466703982/images_5_tu8vfi.jpg","http://res.cloudinary.com/dj8owx8ry/image/upload/v1466703982/images_4_kqtoiu.jpg","http://res.cloudinary.com/dj8owx8ry/image/upload/v1466703982/images_3_llofoj.jpg","http://res.cloudinary.com/dj8owx8ry/image/upload/v1466703982/images_2_wgfhru.jpg","http://res.cloudinary.com/dj8owx8ry/image/upload/v1466703982/images_1_mo680l.jpg"]

(1..10).each do |i|
  user = User.new(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    gender: ['male', 'female'].sample,
    birth_date: rand(Date.civil(1940, 1, 1)..Date.civil(2000, 12, 31)),
    level: ['beginner', 'confirmed', 'expert'].sample,
    phone: '06' + rand(0..9).to_s + rand(0..9).to_s + rand(0..9).to_s + rand(0..9).to_s + rand(0..9).to_s + rand(0..9).to_s + rand(0..9).to_s + rand(0..9).to_s,
    email: 'user' + i.to_s + '@yogastory.fr',
    password: 'aaaaaa',
    yoga_type: yoga_type.sample,
    )
    user.remote_photo_url = user_photos[i - 1]
  user.save!
  p 'user' + i.to_s
end

user1 = User.first
user1.is_admin = true
user1.save

(11..15).each do |i|
  user = User.new(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    gender: ['male', 'female'].sample,
    birth_date: rand(Date.civil(1940, 1, 1)..Date.civil(2000, 12, 31)),
    email: 'user' + i.to_s + '@yogastory.fr',
    phone: '06' + rand(0..9).to_s + rand(0..9).to_s + rand(0..9).to_s + rand(0..9).to_s + rand(0..9).to_s + rand(0..9).to_s + rand(0..9).to_s + rand(0..9).to_s,
    password: 'aaaaaa',
    type: 'Teacher',
    experience: (1970..2015).to_a.sample,
    description: Faker::Lorem.sentence
    )
    user.remote_photo_url = user_photos[i - 1]
  user.save!
  p 'teacher' + i.to_s
end

address_list_lille = ["rue de l'Abbé Aerts","rue de l'Abbé Bonpain","rue de l'Abbé Cousin","rue Abélard","rue d'Aboukir","rue Adolphe","rue Adolphe Casse","avenue Adolphe Max","rue de l'Amidonnerie","rue d'Angleterre","rue Arago","rue de l'Arc","rue des Archives","rue d'Arras","rue d'Artois","rue des Arts","rue de la Baignerie","rue de Bailleul","rue de la Barre","rue Barthélémy-Delespaul","rue Basse","rue du Bastion-du-Meunier","rue Bartholomé-Masurel","rue Baudon","rue Beaucourt-Decourchelle","rue Benvignat","rue de Béthune","boulevard Bigo-Danel","place aux Bleuets","rue des Bonnes-Rappes","rue des Bons-Enfants","rue Boucher-de-Perthes","rue des Bouchers","rue de la Bourse","rue Brûle-Maison du surnom du chansonnier François Cottignies","rue de Bruxelles","rue des Canonniers","boulevard Carnot","rue des Célestines","rue de la Chambre-des-Comptes","rue des Chats-Bossus","rue Charles-le-Quint","rue du Cirque","rue de Courtrai","rue à Claques","rue de la Clef","rue Comtesse","rue Colas","rue de la Collégiale","place du Concert","rue Coquerez","rue du Curé-Saint-Étienne","square Daubenton","rue des Débris-Saint-Étienne","rue des Deux Épées","rue Doudin","square Dutilleul","rue Gambetta","rue de Gand","place de Gand","rue du Gard","place du Général-de-Gaulle (Grand-Place)","place Gilleson","rue Gantois","rue de la Grande-Chaussée","rue Gosselet, en hommage au géologue Jules Gosselet","rue du Gros-Gérard"]
address_list_paris = ["Place du 22 Novembre 1943","Place des 44 enfants d'Izieu","Place du 8 Février 1962","Rue du 8 mai 1945","Place du 8 novembre 1942","Esplanade du 9 novembre 1989","Rue de l'Abbaye","Place de l'Abbé-Basset","Rue de l'Abbé-Carton","Rue de l'Abbé-de-l'Épée","Place de l'Abbé-Franz-Stock","Place de l'Abbé-Georges-Hénocque","Rue de l'Abbé-Gillet","Rue de l'Abbé-Grégoire","Rue de l'Abbé-Groult","Place de l'Abbé-Jean-Lebeuf","Rue de l'Abbé-Migne","Rue de l'Abbé-Patureau","Rue de l'Abbé-Roger-Derry","Avenue de l'Abbé-Roussel","Rue de l'Abbé-Rousselot","Rue de l'Abbé-Soulange-Bodin","Rue des Abbesses","Rue d'Abbeville","Rue Abel","Rue Abel-Ferry","Rue Abel-Gance","Rue Abel-Hovelacque","Passage Abel-Leblanc"]
description = ["Introduction au ","Perfectionnement au ","Venez essayer le ","Débuter en ","Découvrir le "]

lesson_photos = ['http://res.cloudinary.com/dj8owx8ry/image/upload/c_scale,w_275/v1466591298/Photo%20cours/cours19.jpg','http://res.cloudinary.com/dj8owx8ry/image/upload/c_scale,w_275/v1466716405/cours27.jpg','http://res.cloudinary.com/dj8owx8ry/image/upload/c_scale,w_275/v1466590530/Photo%20cours/cours1.jpg','http://res.cloudinary.com/dj8owx8ry/image/upload/c_scale,w_275/v1466590530/Photo%20cours/cours17.jpg','http://res.cloudinary.com/dj8owx8ry/image/upload/c_scale,w_275/v1466590530/Photo%20cours/cours6.jpg','http://res.cloudinary.com/dj8owx8ry/image/upload/c_scale,w_275/v1466590530/Photo%20cours/cours7.jpg','http://res.cloudinary.com/dj8owx8ry/image/upload/c_scale,w_275/v1466590530/Photo%20cours/cours2.jpg','http://res.cloudinary.com/dj8owx8ry/image/upload/c_scale,w_275/v1466716404/cours26.jpg','http://res.cloudinary.com/dj8owx8ry/image/upload/c_scale,w_275/v1466716404/cours25.jpg','http://res.cloudinary.com/dj8owx8ry/image/upload/c_scale,w_275/v1466590530/Photo%20cours/cours3.jpg','http://res.cloudinary.com/dj8owx8ry/image/upload/c_scale,w_275/v1466181840/Photo%20cours/cours8.jpg','http://res.cloudinary.com/dj8owx8ry/image/upload/c_scale,w_275/v1466715622/cours22.jpg','http://res.cloudinary.com/dj8owx8ry/image/upload/c_scale,w_275/v1466181789/Photo%20cours/cours10.jpg','http://res.cloudinary.com/dj8owx8ry/image/upload/c_scale,w_275/v1466181769/Photo%20cours/cours11.jpg','http://res.cloudinary.com/dj8owx8ry/image/upload/c_scale,w_275/v1466715622/cours21.jpg','http://res.cloudinary.com/dj8owx8ry/image/upload/c_scale,w_275/v1466715622/cours24.jpg','http://res.cloudinary.com/dj8owx8ry/image/upload/c_scale,w_275/v1466181681/Photo%20cours/cours18.jpg','http://res.cloudinary.com/dj8owx8ry/image/upload/c_scale,w_275/v1466017414/Photo%20cours/cours14.jpg','http://res.cloudinary.com/dj8owx8ry/image/upload/c_scale,w_275/v1465905324/Photo%20cours/cours15.jpg','http://res.cloudinary.com/dj8owx8ry/image/upload/c_scale,w_275/v1466715622/cours23.jpg']

(1..20).each do |i|
  lesson = Lesson.new(
    name: yoga_type.sample[0],
    teacher_id: User.where(type: 'Teacher').sample.id,
    start_date: Faker::Date.between(Date.today, 1.month.from_now),
    hours: [1, 2, 3, 4].sample,
    minutes: [0, 15, 30, 45].sample,
    price: (10..40).to_a.sample,
    min_students: 1,
    max_students: 4,
    address: (1..10).to_a.sample.to_s + ' ' + [address_list_lille.sample + ', Lille', address_list_paris.sample + ', Paris'].sample
    )
  lesson.valid?
  lesson.update_attribute(:start_date, rand(Date.civil(2016, 6, 1)..Date.civil(2016, 7, 31)))
  lesson.description = description.sample + lesson.name
  lesson.remote_photo_url = lesson_photos[i - 1]
  lesson.save(validate: false)
  p 'lesson' + i.to_s
end

reviews = [[5, "Ce cours était vraiment super"], [5, "Canon! Je recommande vivement"], [4, "Une très bonne première séance de yoga, j'ai été mise en confiance dès mon arrivée et les explications pendant le cours étaient très claires, merci!"], [5, "Un nouveau concept à essayer!"], [4, "Super pratique lorsqu'on part en vacances ou en déplacement profesionnel, professeur aux petits oignons!"], [3, "Séance de qualité, merci!"], [5, "C'est ma 5ème séance et je n'ai qu'une hâte, être la semaine prochaine!"], [4, "Oui, oui, oui"], [3, "bon prof"], [4, "Ambiance très cool"], [5, "Super ambiance pour mon premier cours de Yoga"], [4, "J'ai assisté à ma première séance de Yoga entre copines et en vacances grâce à Yogastory, merci à toute l'équipe"], [4, "Séance fort sympathique, lieu agréable et bonne ambiance pendant le cours"], [5, "R E L A X A N T ! ! !"], [4, "Du vrai yoga, tout simplement"], [5, "Le yoga par un yogi pour des yogis"], [5, "Cette activité devrait être obligatoire à l'école"], [4, "Un moment relaxant, je reviendrai"], [5, "Je fréquence régulièrement les cours proposés par Yogastory depuis que je suis à la retraite, et ça me fait un bien fou!"], [5, "Super concept!"]]

(1..50).each do |i|
  booking = Booking.new(
  user_id: User.all.sample.id,
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
    a = reviews.sample
    booking.update_attributes(review_rating: a[0], review_content: a[1], amount_cents: booking.lesson.price_cents)
  else
    booking.amount_cents = booking.lesson.price_cents
  end
  booking.save!
  p 'booking' + i.to_s
end
