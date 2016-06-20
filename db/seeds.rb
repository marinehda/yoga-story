require 'faker'

# Run using rake db:reset rather than rake db:seed to not break ids logic in this file
# When modifying validators in model, amend this file

# User.delete_all
Lesson.delete_all
# Booking.delete_all
#
# (1..10).each do |i|
#   user = User.new(
#     email: 'user' + i.to_s + '@yogastory.com',
#     password: 'aaaaaa'
#     )
#   user.save!
#   p 'user' + i.to_s
# end
#
# user1 = User.first
# user1.is_admin = true
# user1.save
#
# (11..15).each do |i|
#   user = User.new(
#     email: 'user' + i.to_s + '@yogastory.com',
#     password: 'aaaaaa',
#     type: 'Teacher',
#     experience: (1970..2015).to_a.sample,
#     description: Faker::Lorem.sentence
#     )
#   user.save!
#   p 'teacher' + i.to_s
# end

address_list = ["rue de l'Abbé Aerts","rue de l'Abbé Bonpain","rue de l'Abbé Cousin","rue Abélard","rue d'Aboukir","rue Adolphe","rue Adolphe Casse","avenue Adolphe Max","rue de l'Amidonnerie","rue d'Angleterre","rue Arago","rue de l'Arc","rue des Archives","rue d'Arras","rue d'Artois","rue des Arts","rue de la Baignerie","rue de Bailleul","rue de la Barre","rue Barthélémy-Delespaul","rue Basse","rue du Bastion-du-Meunier","rue Bartholomé-Masurel","rue Baudon","rue Beaucourt-Decourchelle","rue Benvignat","rue de Béthune","boulevard Bigo-Danel","place aux Bleuets","rue des Bonnes-Rappes","rue des Bons-Enfants","rue Boucher-de-Perthes","rue des Bouchers","rue de la Bourse","rue Brûle-Maison du surnom du chansonnier François Cottignies","rue de Bruxelles","rue des Canonniers","boulevard Carnot","rue des Célestines","rue de la Chambre-des-Comptes","rue des Chats-Bossus","rue Charles-le-Quint","rue du Cirque","rue de Courtrai","rue à Claques","rue de la Clef","rue Comtesse","rue Colas","rue de la Collégiale","place du Concert","rue Coquerez","rue du Curé-Saint-Étienne","square Daubenton","rue des Débris-Saint-Étienne","rue des Deux Épées","rue Doudin","square Dutilleul"]

(1..20).each do |i|
  lesson = Lesson.new(
    name: 'lesson' + i.to_s,
    description: Faker::Lorem.sentence,
    teacher_id: (11..15).to_a.sample,
    start_date: Faker::Time.forward(30, :morning),
    price: (10..40).to_a.sample,
    min_students: 2,
    max_students: 5,
    address: (1..10).to_a.sample.to_s + ' ' + address_list.sample + ', Lille'
    )
  lesson.update_attribute(:end_date, lesson.start_date + 3600)
  lesson.save!
  lesson.address = (1..10).to_a.sample.to_s + ' ' + address_list.sample + ', Lille'
  lesson.save!
  p 'lesson' + i.to_s
end
