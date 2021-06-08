require "open-uri"
require 'nokogiri'

puts "Clearing database..."
Parking.destroy_all
Review.destroy_all
User.destroy_all

puts "Clearing finished!"

# puts "Start the Scraping"

# url = "xmlSeed/seedBikes.kml"

# puts "url checked!"
# file = File.open(url)
# document  = Nokogiri::XML(file)

# puts "html_doc checked!"

# document.search('Placemark').each do |coordinates|
#   idx = rand(images.count)
#   file = URI.open(images[idx])
#   name = coordinates.search('name').text.strip.include?("/") ? coordinates.search('name').text.strip.split("/")[1].strip : coordinates.search('name').text.strip
#   longitude = coordinates.search('coordinates').text.strip.split(",")[0].to_f
#   p longitude
#   latitude = coordinates.search('coordinates').text.strip.split(",")[1].to_f
#   p latitude
#   parking = Parking.create(name: name, latitude: latitude, longitude: longitude, price: rand(0..1), risk_level: 0)
#   parking.photos.attach(io: file, filename: 'parking.png', content_type: 'image/jpg')
#   puts "Created #{Parking.count} parkings!"
# end

# puts "Finished! Created #{Parking.count} parkings!"
puts "Creating some users..."

lena = User.new(email: 'lenatheboss@hotmail.com', password: '1234567', name: 'Lena')
lena.save!

jose = User.new(email: 'jose@hotmail.com', password: '1234567', name: 'Jose')
jose.save!

kenn = User.new(email: 'kenn@hotmail.com', password: '1234567', name: 'Kenn')
kenn.save!

doug = User.new(email: 'doug@hotmail.com', password: '1234567', name: 'Doug')
doug.save!

yann = User.new(email: 'yann@hotmail.com', password: '1234567', name: 'Yann')
yann.save!

trouni = User.new(email: 'trouni@hotmail.com', password: '1234567', name: 'Trouni')
trouni.save!

noemi = User.new(email: 'noemi@hotmail.com', password: '1234567', name: 'Noemi')
noemi.save!

lee = User.new(email: 'lee@hotmail.com', password: '1234567', name: 'Lee')
lee.save!

kazu = User.new(email: 'kazu@hotmail.com', password: '1234567', name: 'Kazu')
kazu.save!

satomi = User.new(email: 'satomi@hotmail.com', password: '1234567', name: 'Satomi')
satomi.save!

kate = User.new(email: 'kate@hotmail.com', password: '1234567', name: 'Kate')
kate.save!

sergio = User.new(email: 'sergio@hotmail.com', password: '1234567', name: 'Sergio')
sergio.save!

puts "Created #{User.count} users!"


puts "Creating some random reviews..."

review_paid1 = Review.new(comment: "Safe and easy. Too expensive though... I'd rather save my money next time.", risk_level: 0)
review_paid2 = Review.new(comment: "Have to pay if you don't spend at least ¥1000 in Atre. Just a heads up!", risk_level: 0)
review_5a = Review.new(comment: "Perfect! Very quiet and had no issues. Will definitely use this spot again.", risk_level: 0)
review_5b = Review.new(comment: "Brilliant find! Will definitely use it again. Thanks!", risk_level: 0) 
review_5c = Review.new(comment: "Great little hidden gem! I've been using this place for a while now. Such a nice spot.", risk_level: 0) 
review_4a = Review.new(comment: "Great place! I've used this spot twice now. Quite a few bikes, but it seems safe.", risk_level: 0)
review_4b = Review.new(comment: "Nice little spot. Thanks for sharing!", risk_level: 0)
review_3a = Review.new(comment: "Good. No problems this time. The street is quite busy though. I might try and look for a quieter place.", risk_level: 0)
review_3b = Review.new(comment: "Not real complaints. I could leave my bike here all morning without any issues.", risk_level: 0)
review_2a = Review.new(comment: "I could park my bike here, but one of the locals living across the road warned me not to.", risk_level: 1)
review_2b = Review.new(comment: "Didn't have any problems, but I saw inspectors down the street. Probably won't risk leaving it here again.", risk_level: 1)
review_1a = Review.new(comment: "Terrible place! Someone stole my bicycle seat. WTF? NOT recommended.", risk_level: 1)
review_1b = Review.new(comment: "Do NOT use this spot. My bike was impounded. Had to pay ¥3000 to get it back...", risk_level: 1)
reviews = [review_1a, review_1b, review_2a, review_2b, review_3a, review_3b, review_4a, review_4b, review_5a, review_5b, review_5c]

# 600.times do
#   review = reviews.sample.dup
#   review.user = User.all.sample
#   review.parking = Parking.all.sample
#   review.save!
# end


puts "Created #{Review.count} random reviews!"
puts "Creating some pitch reviews..."



image3 = ['https://res.cloudinary.com/dqjzulqyf/image/upload/v1623029881/Baiku/5%20Meguro%20Seeds/Atre_Meguro_Bicycle_Parking_bnufzz.png', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623029517/Baiku/5%20Meguro%20Seeds/Selva_Meguro_tlgdbn.png',
          'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623029518/Baiku/5%20Meguro%20Seeds/Aqua_Meguro_r7b9an.png', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623032229/Baiku/5%20Meguro%20Seeds/Sushi_Tatsu_qwabwo.png', 
          'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623046451/Baiku/5%20Meguro%20Seeds/Kibogaoka_Park_wuamqs.png']

names3 = ['Atre Meguro Bicycle Parking', 'Selva Meguro', 'Aqua Meguro', 'Sushi Tatsu', 'Kibogaoka Park']

description3 = ['Very close to the station. Lots of space for parking.', 'Unused. Often empty. Have used it several times now.',
                'This spot is on a side street in front of Hoshino building (south side) close to Meguro station. Few bikes are usually parked here.',
                'Little street near this sushi restaurant. Very quiet area.', 'Area right next to the park. Many people use it, so it seems quite safe.']




file = URI.open(image3[0])

atre = Parking.new(name: names3[0], description: description3[0], price: 1, latitude: 35.63443467268105, longitude: 139.71603872641003, risk_level: 0)
atre.save!
atre.photos.attach(io: file, filename: 'parking.png', content_type: 'image/jpg')

review = review_paid1
review.user = kenn
review.parking = atre
review.save!

review = review_paid2
review.user = yann
review.parking = atre
review.save!

file = URI.open(image3[1])
selva = Parking.new(name: names3[1], description: description3[1], price: 0, latitude: 35.63267101798207, longitude: 139.7181321379397, risk_level: 0)
selva.save!
selva.photos.attach(io: file, filename: 'parking.png', content_type: 'image/jpg')

review = review_1a
review.user = lena
review.parking = selva
review.save!

review = review_2a
review.user = jose
review.parking = selva
review.save!

review = review_3a
review.user = jose
review.parking = selva
review.save!

review = review_2b
review.user = kenn
review.parking = selva
review.save!

file = URI.open(image3[2])
aqua = Parking.new(name: names3[2], description: description3[2], price: 0, latitude: 35.63369948256393, longitude: 139.71950072500582, risk_level: 0)
aqua.save!
aqua.photos.attach(io: file, filename: 'parking.png', content_type: 'image/jpg')

review = review_4b
review.user = kenn
review.parking = aqua
review.save!

review = review_3b
review.user = noemi
review.parking = aqua
review.save!

review = review_5b
review.user = sergio
review.parking = aqua
review.save!

review = review_2b
review.user = kazu
review.parking = aqua
review.save!

file = URI.open(image3[3])
sushi = Parking.new(name: names3[3], description: description3[3], price: 0, latitude: 35.63332594010175, longitude: 139.71745909737535, risk_level: 0)
sushi.save!
sushi.photos.attach(io: file, filename: 'parking.png', content_type: 'image/jpg')

review = review_1b
review.user = doug
review.parking = sushi
review.save!

review = review_2b
review.user = lena
review.parking = sushi
review.save!

file = URI.open(image3[4])
kibogaoka = Parking.new(name: names3[4], description: description3[4], price: 0, latitude: 35.63162602727671, longitude: 139.71835186522134, risk_level: 0)
kibogaoka.save!
kibogaoka.photos.attach(io: file, filename: 'parking.png', content_type: 'image/jpg')


review = review_5c
review.user = lee
review.parking = kibogaoka
review.save!

review = review_5a
review.user = trouni
review.parking = kibogaoka
review.save!

review = review_4a
review.user = kazu
review.parking = kibogaoka
review.save!

puts "Created #{Review.count} pitch reviews!"
puts "Done!"
