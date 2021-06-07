require "open-uri"
require 'nokogiri'

puts "Clearing database..."
Parking.destroy_all
Review.destroy_all
User.destroy_all

puts "Clearing finished!"

# name = ['Impact HUB Tokyo', 'Maruetsu Meguro', 'Riverside Earth Training Center', 'Switch Coffee Tokyo',
#         'JR Tokyumeguro Bldg', 'Otori-jinja Shrine', 'Meguro Tokyu Store', 'Family Mart Otori-jinja',
#         '7 Eleven Meguro Gyoninzaka', 'Pine Heights Meguro', '7 Eleven Meguro Central Suqare', 'Prime Urban Meguro',
#         'Cocokara Fine Meguro', 'Image Studio 109 Meguro Studio', 'Family Mart Meguro East', 'Voice Training Academy Meguro', 'Seven-Eleven Minatoku Tameikesanno store',
#         'A1-01.千代田区役所 / Chiyoda City Office', 'Tokyo Kusei Kaikan building(Metro A5 Exit)', 'Nishi-Shinbashi 1Chome (Sotobori St.)', 'TORANOMON HILLS',
#         'Nishi-Shinbashi 2-Chome (Shintora St.)', 'Atago GREEN HILLS']

# address = ['2-11-3 Meguro, Tokyo', '2-21-23 Meguro, Tokyo', '2-chōme-1-19 Shimomeguro', '1-17-23 Meguro, Tokyo', '3-1 Shinagawa, Tokyo',
#            '3-1-23 Meguro, Tokyo', '2-24-13 Shinagawa, Tokyo', '3-10 Meguro, Tokyo', '1-7-8 Meguro, Tokyo', '2-11-3 Meguro, Tokyo', '3-1-1 Shinagawa, Tokyo',
#            '1-11-11 Meguro, Tokyo', '1-6-17 Meguro, Tokyo', '2-24-12 Shimomeguro, Tokyo', '2-12-2 Meguro, Tokyo', '2-18-16 Shinagawa, Tokyo', '港区赤坂1-4-41',
#            '千代田区九段南1-2-1', '千代田区飯田橋3-5-1', '港区西新橋1-12-10', '港区虎ノ門1-23-1', '港区西新橋2-22-7', '港区愛宕2-5-1']

# description = ['Free for members', 'Free for customers', 'Quiet area near the a training center', 'Small street. Cafe and river nearby', 'Lots of parking spaces',
#                'Next to Otori-jinja', 'Free for customers', 'Quiet street behind Family Mart. Free for customers', 'Free for customers', "Quiet residential area. Mainly seniors that don't say much",
#                'Free for customers', 'Small street near Mita Okanoue Park', 'Free for customers', 'Opposite a photography studio', 'Free for customers', 'Next to an academy. Plenty of space']

# images = ['https://res.cloudinary.com/dqjzulqyf/image/upload/v1623025062/Baiku/D3B626F4-FAFD-43FB-963B-A039A5BF5C35_d93gp6.jpg',
#           'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623025062/Baiku/6183C6A0-E4BB-4A5E-8D4F-A95BA744AE77_ohi8wu.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623025061/Baiku/7BF92020-FFBA-46B7-B9D3-5788CB0E7EDB_utkfru.jpg',
#           'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623025061/Baiku/282F6206-295E-406C-83A1-A505C964380D_tu7zsn.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623025061/Baiku/1F97E027-531B-45A2-9064-873A90FE748D_icopks.jpg',
#           'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623025061/Baiku/3322080E-DA65-476F-9AB5-11FB684F657E_wlfkby.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623025061/Baiku/59911A1B-F966-45FB-938E-80AB40703D27_gtqr8i.jpg',
#           'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623025061/Baiku/1C080CEA-F49E-4EAA-A4DE-99CB2D200900_nzqlmo.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623025060/Baiku/31623B52-C231-4544-A63F-F940466F6CA0_wpnvyd.jpg',
#           'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623025060/Baiku/560D1042-DBAD-4B74-8E14-9D5F58164E60_cqkszs.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623025060/Baiku/C6B0282A-3C3B-4255-9420-5BBE547CB541_modma7.jpg',
#           'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623025060/Baiku/7884D7D7-82D7-4E75-A6E0-ED05E54BC366_ocy6j3.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623025059/Baiku/B1432338-ADC3-4267-9ACA-491BD4CDA05F_qokltr.jpg',
#           'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623025059/Baiku/IMG_20210606_140711_svchqc.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623025059/Baiku/7F23D651-64E1-4B25-9378-009632192E32_zzrf1b.jpg',
#           'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623025058/Baiku/A8882A27-58C1-41C2-880F-790D26696CF1_lfdvxs.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623025058/Baiku/IMG_20210606_140433_ci4lfm.jpg',
#           'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623025058/Baiku/08ECAD2C-BD86-48D6-A8E6-28CE6B5D87EC_g46omk.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623025058/Baiku/E45E125D-B2E9-4CC1-9B78-FCB61BA7E656_t2kyif.jpg',
#           'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623025057/Baiku/65560008-E2C3-47D0-A535-7E84F08A11F1_qwihxt.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623025057/Baiku/IMG_20210606_140439_npgtgs.jpg',
#           'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623025057/Baiku/7A675F15-EB87-4869-88DD-728C35886E9A_ap8qx5.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623025056/Baiku/C4A26AEB-810B-4B15-9966-85ECD5AFB112_f6mp0o.jpg',
#           'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623025056/Baiku/0D8A8C16-49C2-42F9-B2EC-FA06A8320E09_a8igkw.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623025056/Baiku/763C5461-5C63-46D3-86EF-540AA9B59A83_h74xs3.jpg',
#           'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623025056/Baiku/B54E93E3-A0B5-4AF2-9CEF-F229F0214DD6_wf3rdo.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623025052/Baiku/IMG_20210606_140746_q91i27.jpg',
#           'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623025051/Baiku/IMG_20210606_142545_ceb1ne.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623025050/Baiku/IMG_20210606_140741_z5yg4k.jpg',
#           'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024838/Baiku/B831FF3D-5350-4541-95B5-4D2E138E93FD_g9k50r.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024837/Baiku/D92C4450-FB81-47DE-9692-38AFC0DC5394_lqhdff.jpg',
#           'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024837/Baiku/89EE4448-1423-4062-B81B-03A2C1F95369_faodxw.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024836/Baiku/8A0F56D9-C7C5-4CD3-A853-7028D24584C1_arsbmn.jpg',
#           'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024835/Baiku/89B28167-ACFF-45D0-8174-BB9EBC2A234C_wtm3xt.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024835/Baiku/527FA4B5-4853-4E22-A694-C44E8E5E7D81_eltgob.jpg',
#           'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024835/Baiku/AB5F23F6-63D8-41A1-891A-C2FE75137DB2_scy6uu.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024833/Baiku/2E773E55-234A-4C31-AB87-0DFFAB9B5B01_jh2wrv.jpg',
#           'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024832/Baiku/A0DBB797-4727-4CE1-AFC5-22BF566C06C6_cl0mty.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024832/Baiku/BC1F58FB-A263-4396-ABAF-DAD84DDC4CD8_bp4kob.jpg',
#           'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024831/Baiku/3E668549-012D-4755-90F3-F5A9639446D3_a89abe.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024831/Baiku/144E3EFC-3B24-4D25-B6A2-599CC9ED6568_e4rmov.jpg',
#           'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024828/Baiku/AD5F7AB7-CCC7-40A5-9FFD-61DF36462077_f9hyvy.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024828/Baiku/4BACF4F7-408E-45E5-A3E5-137E8AA146E2_xdaze2.jpg',
#           'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024827/Baiku/19848F52-5515-472C-B040-5CAB244A3488_h9ouol.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024827/Baiku/3814239D-011C-4BA8-88E7-14CF8A51BC4C_nhsi9f.jpg',
#           'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024825/Baiku/879DBF8E-1DA4-4E91-B5A3-DEF7B069CAE8_q4xuhz.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024824/Baiku/009A8445-CA1F-4EBD-8929-B0D9FF483147_anmv3x.jpg',
#           'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024824/Baiku/9442BF0D-EE0F-4383-AE7C-488FAD7C6A8F_ffskev.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024823/Baiku/8E359BD8-4D2A-4F93-BAB8-45BDF8E32EAA_e2ktz8.jpg',
#           'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024823/Baiku/9CC2EBB9-2CE6-4A2F-A16A-93B74D75C776_pufygb.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024821/Baiku/EE4D861E-9246-49B8-99C9-E923D91C18FA_d0slrh.jpg',
#           'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024820/Baiku/042B6CF1-1BB9-4674-92D3-E19E468D6107_plqhxx.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024236/Baiku/20_dvrjp6.jpg',
#           'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024236/Baiku/19_qgknyr.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024235/Baiku/18_er1ng0.jpg',
#           'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024235/Baiku/16_xftz3j.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024235/Baiku/14_uitqc3.jpg',
#           'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024235/Baiku/17_vb0fx8.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024235/Baiku/11_yjgerg.jpg',
#           'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024235/Baiku/15_ba2gap.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024235/Baiku/13_deevqm.jpg',
#           'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024235/Baiku/12_yqe48i.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024235/Baiku/8_zxxyiz.jpg',
#           'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024235/Baiku/10_o6zsbh.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024234/Baiku/9_tsvpdu.jpg',
#           'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024234/Baiku/7_ercngl.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024234/Baiku/3_dwyzlz.jpg',
#           'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024234/Baiku/5_yfwwss.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024234/Baiku/1_xhfhji.jpg',
#           'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024234/Baiku/2_lsbrqx.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024234/Baiku/6_niahhy.jpg',
#           'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024234/Baiku/4_exoeov.jpg']

# # puts "Creating parking"

# # name.each_with_index do |nam,idx|

# #   p images[idx]
# #   file = URI.open(images[idx])
# #   parking = Parking.new(name: nam, address: address[idx], description: description[idx], price: rand(0..1))
# #   parking.save!
# #   parking.photos.attach(io: file, filename: 'parking.png', content_type: 'image/jpg')
# #   puts "Parking #{idx + 1} created!"

# # end

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

allan = User.new(email: 'allan@hotmail.com', password: '1234567', name: 'Allan')
allan.save!

kenn = User.new(email: 'kenn@hotmail.com', password: '1234567', name: 'Kenn')
kenn.save!

doug = User.new(email: 'doug@hotmail.com', password: '1234567', name: 'Doug')
doug.save!

puts "Created #{User.count} users!"



image3 = ['https://res.cloudinary.com/dqjzulqyf/image/upload/v1623029881/Baiku/5%20Meguro%20Seeds/Atre_Meguro_Bicycle_Parking_bnufzz.png', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623029517/Baiku/5%20Meguro%20Seeds/Selva_Meguro_tlgdbn.png',
          'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623029518/Baiku/5%20Meguro%20Seeds/Aqua_Meguro_r7b9an.png', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623032229/Baiku/5%20Meguro%20Seeds/Sushi_Tatsu_qwabwo.png']

names3 = ['Atre Meguro Bicycle Parking', 'Selva Meguro', 'Aqua Meguro', 'Sushi Tatsu']

address3 = ['2-16 Kamiosaki, Tokyo', '3-10 Kamiosaki, Tokyo', '3-2-9 Kamiosaki, Tokyo', '3-6-1 Kamiosaki, Tokyo']

description3 = ['Very close to the station. Lots of space for parking.', 'Unused. Often empty. Have used it several times now.',
                'This spot is on a side street in front of Hoshino building (south side) close to Meguro station. Few bikes are usually parked here.',
                'Little street near this sushi restaurant. Very quiet area.']




file = URI.open(image3[0])
atre = Parking.new(name: names3[0], description: description3[0], risk_level: 1, latitude: 35.63443467268105, longitude: 139.71603872641003)
atre.save!
atre.photos.attach(io: file, filename: 'parking.png', content_type: 'image/jpg')

# 800.times do
#   review = reviews.sample.dup
#   review.user = User.all.sample
#   review.parking = atre
#   review.save!
# end

file = URI.open(image3[1])
selva = Parking.new(name: names3[1], description: description3[1], risk_level: 0, latitude: 35.63267101798207, longitude: 139.7181321379397)
selva.save!
selva.photos.attach(io: file, filename: 'parking.png', content_type: 'image/jpg')


# review = review_1
# review.user = lena
# review.parking = selva
# review.save!

# review = review_2
# review.user = jose
# review.parking = selva
# review.save!

file = URI.open(image3[2])
aqua = Parking.new(name: names3[2], description: description3[2], risk_level: 0, latitude: 35.63332594010175, longitude: 139.71745909737535)
aqua.save!
aqua.photos.attach(io: file, filename: 'parking.png', content_type: 'image/jpg')

# review = review_5
# review.user = jose
# review.parking = aqua
# review.save!

# review = review_4
# review.user = kenn
# review.parking = aqua
# review.save!

# review = review_3
# review.user = doug
# review.parking = aqua
# review.save!

file = URI.open(image3[3])
sushi = Parking.new(name: names3[3], description: description3[3], risk_level: 0, latitude: 35.63369948256393, longitude: 139.71950072500582)
sushi.save!
sushi.photos.attach(io: file, filename: 'parking.png', content_type: 'image/jpg')


# review = review_1
# review.user = lena
# review.parking = sushi
# review.save!

# review = review_2
# review.user = jose
# review.parking = sushi
# review.save!

puts "Creating some reviews..."


review_5 = Review.new(comment: "Perfect! Very quiet and had no issues. Will definitely use this spot again.", risk_level: 0)
review_4 = Review.new(comment: "Great place! I've used this spot twice now. Quite a few bikes, but I", risk_level: 0)
review_3 = Review.new(comment: "Good. No problems this time. The street is quite busy though. I might try and look for a quieter place.", risk_level: 0)
review_2 = Review.new(comment: "I could park my bike here, but one of the locals living across the road warned me not to.", risk_level: 1)
review_1 = Review.new(comment: "Terrible place! Someone stole my bicycle seat. WTF? NOT recommended.", risk_level: 1)
reviews = [review_1, review_2, review_3, review_4, review_5]




10.times do
  review = reviews.sample.dup
  review.user = User.all.sample
  review.parking = Parking.all.sample
  review.save!
end


puts "Created #{Review.count} reviews!"
puts "Done!"
