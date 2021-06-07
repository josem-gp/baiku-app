require "open-uri"

puts "Clearing database..."
Parking.destroy_all
Review.destroy_all
User.destroy_all

name = ['Impact HUB Tokyo', 'Riverside Earth Training Center', 'Switch Coffee Tokyo',
        'JR Tokyumeguro Bldg', 'Otori-jinja Shrine', 'Meguro Tokyu Store', 'Family Mart Otori-jinja', 'Pine Heights Meguro', '7 Eleven Meguro Central Suqare', 'Prime Urban Meguro',
        'Cocokara Fine Meguro', 'Image Studio 109 Meguro Studio', 'Family Mart Meguro East', 'Voice Training Academy Meguro']

address = ['2-11-3 Meguro, Tokyo', '2-chōme-1-19 Shimomeguro', '1-17-23 Meguro, Tokyo', '3-1 Shinagawa, Tokyo',
           '3-1-23 Meguro, Tokyo', '2-24-13 Shinagawa, Tokyo', '3-10 Meguro, Tokyo', '2-11-3 Meguro, Tokyo', '3-1-1 Shinagawa, Tokyo',
           '1-11-11 Meguro, Tokyo', '1-6-17 Meguro, Tokyo', '2-24-12 Shimomeguro, Tokyo', '2-12-2 Meguro, Tokyo', '2-18-16 Shinagawa, Tokyo']

description = ['Free for members', 'Free for customers', 'Quiet area near the a training center', 'Small street. Cafe and river nearby', 'Lots of parking spaces',
               'Next to Otori-jinja', 'Free for customers', 'Quiet street behind Family Mart. Free for customers', 'Free for customers', "Quiet residential area. Mainly seniors that don't say much",
               'Free for customers', 'Small street near Mita Okanoue Park', 'Free for customers', 'Opposite a photography studio', 'Free for customers', 'Next to an academy. Plenty of space']

images = ['https://res.cloudinary.com/dqjzulqyf/image/upload/v1623030470/Baiku/5%20Meguro%20Seeds/default-image_fqkirf.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623030470/Baiku/5%20Meguro%20Seeds/default-image_fqkirf.jpg', 
          'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623030470/Baiku/5%20Meguro%20Seeds/default-image_fqkirf.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623030470/Baiku/5%20Meguro%20Seeds/default-image_fqkirf.jpg', 
          'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623030470/Baiku/5%20Meguro%20Seeds/default-image_fqkirf.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623030470/Baiku/5%20Meguro%20Seeds/default-image_fqkirf.jpg', 
          'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623030470/Baiku/5%20Meguro%20Seeds/default-image_fqkirf.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623030470/Baiku/5%20Meguro%20Seeds/default-image_fqkirf.jpg', 
          'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623030470/Baiku/5%20Meguro%20Seeds/default-image_fqkirf.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623030470/Baiku/5%20Meguro%20Seeds/default-image_fqkirf.jpg', 
          'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623030470/Baiku/5%20Meguro%20Seeds/default-image_fqkirf.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623030470/Baiku/5%20Meguro%20Seeds/default-image_fqkirf.jpg', 
          'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623030470/Baiku/5%20Meguro%20Seeds/default-image_fqkirf.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623030470/Baiku/5%20Meguro%20Seeds/default-image_fqkirf.jpg', ]

puts "Creating parking"

name.each_with_index do |nam,idx|

  p images[idx]
  file = URI.open(images[idx])
  parking = Parking.new(name: nam, address: address[idx], description: description[idx], price: rand(0..1))
  parking.save!
  parking.photos.attach(io: file, filename: 'parking.png', content_type: 'image/jpg')
  puts "Parking #{idx + 1} created!"

end

puts "Created #{Parking.count} parkings!"

puts "Creating some users..."

lena = User.new(email: 'lenatheboss@hotmail.com', password: '1234567', name: 'Lena')
lena.save!

jose = User.new(email: 'jose@hotmail.com', password: '1234567', name: 'Jose')
jose.save!

allan = User.new(email: 'allan@hotmail.com', password: '1234567', name: 'Allan')
allan.save!

kenn = User.new(email: 'kenn@hotmail.com', password: '1234567', name: 'Kenn')
kenn.save!

doug = User.new(email: 'doug@hotmail.com', password: '1234567', name: 'Doug')
doug.save!

puts "Created #{User.count} users!"

puts "Creating some reviews..."

review_5 = Review.new(comment: "Perfect! Very quiet and had no issues. Will definitely use this spot again.", rating: 5)
review_4 = Review.new(comment: "Great place! I've used this spot twice now. Quite a few bikes, but I was able to leave my bike all day here.", rating: 4)
review_3 = Review.new(comment: "Good. No problems this time. The street is quite busy though. I might try and look for a quieter place.", rating: 3)
review_2 = Review.new(comment: "I could park my bike here, but one of the locals living across the road warned me not to.", rating: 2)
review_1 = Review.new(comment: "Terrible place! Someone stole my bicycle seat. WTF? NOT recommended.", rating: 1)
reviews = [review_1, review_2, review_3, review_4, review_5]

20.times do
  review = reviews.sample.dup
  review.user = User.all.sample
  review.parking = Parking.all.sample
  review.save!
end


puts "Created #{Review.count} reviews!"
puts "Done!"



image3 = ['https://res.cloudinary.com/dqjzulqyf/image/upload/v1623029881/Baiku/5%20Meguro%20Seeds/Atre_Meguro_Bicycle_Parking_bnufzz.png', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623029517/Baiku/5%20Meguro%20Seeds/Selva_Meguro_tlgdbn.png',
          'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623029518/Baiku/5%20Meguro%20Seeds/Aqua_Meguro_r7b9an.png', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623032229/Baiku/5%20Meguro%20Seeds/Sushi_Tatsu_qwabwo.png']

names3 = ['Atre Meguro Bicycle Parking', 'Selva Meguro', 'Aqua Meguro', 'Sushi Tatsu']

address3 = ['2-16 Kamiosaki, Tokyo', '3-10 Kamiosaki, Tokyo', '3-2-9 Kamiosaki, Tokyo', '3-6-1 Kamiosaki, Tokyo']

description3 = ['Very close to the station. Lots of space for parking.', 'Unused. Often empty. Have used it several times now.', 
'This spot is on a side street in front of Hoshino building (south side) close to Meguro station. Few bikes are usually parked here.', 
'Little street near this sushi restaurant. Very quiet area.']




file = URI.open(image3[0])
atre = Parking.new(name: names3[0], description: description3[0], price: 1, latitude: 35.63443467268105, longitude: 139.71603872641003)
atre.save!
atre.photos.attach(io: file, filename: 'parking.png', content_type: 'image/jpg')

2.times do
  review = reviews.sample.dup
  review.user = User.all.sample
  review.parking = atre
  review.save!
end

file = URI.open(image3[1])
selva = Parking.new(name: names3[1], description: description3[1], price: 0, latitude: 35.63267101798207, longitude: 139.7181321379397)
selva.save!
selva.photos.attach(io: file, filename: 'parking.png', content_type: 'image/jpg')


review = review_1
review.user = lena
review.parking = selva
review.save!

review = review_2
review.user = jose
review.parking = selva
review.save!

file = URI.open(image3[2])
aqua = Parking.new(name: names3[2], description: description3[2], price: 0, latitude: 35.63332594010175, longitude: 139.71745909737535)
aqua.save!
aqua.photos.attach(io: file, filename: 'parking.png', content_type: 'image/jpg')

review = review_5
review.user = jose
review.parking = aqua
review.save!

review = review_4
review.user = kenn
review.parking = aqua
review.save!

review = review_3
review.user = doug
review.parking = aqua
review.save!

file = URI.open(image3[3])
sushi = Parking.new(name: names3[3], description: description3[3], price: 0, latitude: 35.63369948256393, longitude: 139.71950072500582)
sushi.save!
sushi.photos.attach(io: file, filename: 'parking.png', content_type: 'image/jpg')


review = review_1
review.user = lena
review.parking = sushi
review.save!

review = review_2
review.user = jose
review.parking = sushi
review.save!