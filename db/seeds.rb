puts "Clearing all db"
Parking.destroy_all

name = ['Impact HUB Tokyo', 'Maruetsu Meguro', 'Riverside Earth Training Center', 'Switch Coffee Tokyo', 'JR Tokyumeguro Bldg', 'Otori-jinja Shrine', 'Meguro Tokyu Store', 'Family Mart Otori-jinja', '7 Eleven Meguro Gyoninzaka', 'Pine Heights Meguro', '7 Eleven Meguro Central Suqare', 'Prime Urban Meguro', 'Cocokara Fine Meguro', 'Image Studio 109 Meguro Studio', 'Family Mart Meguro East', 'Voice Training Academy Meguro']

address = ['2-11-3 Meguro, Tokyo', '2-21-23 Meguro, Tokyo', '2-1-19 Shimomeguro, Tokyo', '1-17-23 Meguro, Tokyo', '3-1 Shinagawa, Tokyo', '3-1-23 Meguro, Tokyo', '2-24-13 Shinagawa, Tokyo', '3-10 Meguro, Tokyo', '1-7-8 Meguro, Tokyo', '2-11-3 Meguro, Tokyo', '3-1-1 Shinagawa, Tokyo', '1-11-11 Meguro, Tokyo', '1-6-17 Meguro, Tokyo', '2-24-12 Shimomeguro, Tokyo', '2-12-2 Meguro, Tokyo', '2-18-16 Shinagawa, Tokyo']

description = ['Free for members', 'Free for customers', 'Quiet area near the a training center', 'Small street. Cafe and river nearby', 'Lots of parking spaces', 'Next to Otori-jinja', 'Free for customers', 'Quiet street behind Family Mart. Free for customers', 'Free for customers', "Quiet residential area. Mainly seniors that don't say much", 'Free for customers', 'Small street near Mita Okanoue Park', 'Free for customers', 'Opposite a photography studio', 'Free for customers', 'Next to an academy. Plenty of space']

# image = %w[]

puts "Creating parking"

name.each_with_index do |nam,idx|

  parking = Parking.new(name: nam, address: address[idx], description: description[idx], price: rand(0..1))
  parking.save!

end

puts "Created #{Parking.count} parkings!"
puts "Done!"
