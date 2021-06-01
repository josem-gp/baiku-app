require "open-uri"

puts "Clearing database..."
Parking.destroy_all
Review.destroy_all
User.destroy_all

name = ['Impact HUB Tokyo', 'Maruetsu Meguro', 'Riverside Earth Training Center', 'Switch Coffee Tokyo',
        'JR Tokyumeguro Bldg', 'Otori-jinja Shrine', 'Meguro Tokyu Store', 'Family Mart Otori-jinja',
        '7 Eleven Meguro Gyoninzaka', 'Pine Heights Meguro', '7 Eleven Meguro Central Suqare', 'Prime Urban Meguro',
        'Cocokara Fine Meguro', 'Image Studio 109 Meguro Studio', 'Family Mart Meguro East', 'Voice Training Academy Meguro']

address = ['2-11-3 Meguro, Tokyo', '2-21-23 Meguro, Tokyo', '2-chōme-1-19 Shimomeguro', '1-17-23 Meguro, Tokyo', '3-1 Shinagawa, Tokyo', '3-1-23 Meguro, Tokyo', '2-24-13 Shinagawa, Tokyo', '3-10 Meguro, Tokyo', '1-7-8 Meguro, Tokyo', '2-11-3 Meguro, Tokyo', '3-1-1 Shinagawa, Tokyo', '1-11-11 Meguro, Tokyo', '1-6-17 Meguro, Tokyo', '2-24-12 Shimomeguro, Tokyo', '2-12-2 Meguro, Tokyo', '2-18-16 Shinagawa, Tokyo']

description = ['Free for members', 'Free for customers', 'Quiet area near the a training center', 'Small street. Cafe and river nearby', 'Lots of parking spaces', 'Next to Otori-jinja', 'Free for customers', 'Quiet street behind Family Mart. Free for customers', 'Free for customers', "Quiet residential area. Mainly seniors that don't say much", 'Free for customers', 'Small street near Mita Okanoue Park', 'Free for customers', 'Opposite a photography studio', 'Free for customers', 'Next to an academy. Plenty of space']

images = ['https://res.cloudinary.com/dqjzulqyf/image/upload/v1622449850/Baiku/impactHub_pq4jb2.png', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1622449850/Baiku/maruetsu_meguro_plqefa.jpg',
          'https://res.cloudinary.com/dqjzulqyf/image/upload/v1622451058/Baiku/riverside_m5fsig.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1622452484/Baiku/SWITCH_COFFEE_SHOP_fhqw3n.jpg',
          'https://res.cloudinary.com/dqjzulqyf/image/upload/v1622450476/Baiku/jr_megurobldg_uz6gbe.png', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1622451919/Baiku/otorikjinja_fmlvjb.png',
          'https://res.cloudinary.com/dqjzulqyf/image/upload/v1622451063/Baiku/tokyu_store_vgrfjh.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1622451800/Baiku/family_mart_otori_dyn6kd.jpg',
          'https://res.cloudinary.com/dqjzulqyf/image/upload/v1622451064/Baiku/7_eleven_gyoninzaka_ynhhyo.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1622451946/Baiku/pine_heights_oaws8m.jpg',
          'https://res.cloudinary.com/dqjzulqyf/image/upload/v1622451066/Baiku/seven_eleven_central_square_bxxztf.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1622450705/Baiku/Prime_urban_meguro_t1oxmf.jpg',
          'https://res.cloudinary.com/dqjzulqyf/image/upload/v1622450773/Baiku/cocokara_fine_byiw0u.png', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1622451828/Baiku/Image_Studio_109_Meguro_studio_wnnn7n.jpg',
          'https://res.cloudinary.com/dqjzulqyf/image/upload/v1622450373/Baiku/familymart_meguroeast_axm4jc.png', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1622451077/Baiku/voice_academy_et6sie.png']

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

user = User.new(email: 'lenatheboss@hotmail.com', password: '1234567', name: 'Lena')
user.save!

user = User.new(email: 'jose@hotmail.com', password: '1234567', name: 'Jose')
user.save!

user = User.new(email: 'allan@hotmail.com', password: '1234567', name: 'Allan')
user.save!

puts "Created #{User.count} users!"

puts "Creating some reviews..."

review_1 = Review.new(comment: "Great place! Very quiet and had no issues", rating: rand(4..5))
review_2 = Review.new(comment: "Good. No problems. Strange people nearby though. I might try and look for a better place.", rating: rand(2..3))
review_3 = Review.new(comment: "Terrible place! Someone stole my bicycle seat. NOT recommended.", rating: 1)
reviews = [review_1, review_2, review_3]

20.times do
  review = reviews.sample.dup
  review.user = User.all.sample
  review.parking = Parking.all.sample
  review.save!
end


puts "Created #{Review.count} reviews!"
puts "Done!"