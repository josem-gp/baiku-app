class SeedingJob < ApplicationJob
  queue_as :default

  def perform
    require "open-uri"
    require 'nokogiri'

    puts "Clearing finished!"

    puts "Start the Scraping"

    url = "xmlSeed/seedBikes.kml"

    puts "url checked!"
    file = File.open(url)
    document  = Nokogiri::XML(file)

    puts "html_doc checked!"

    images = ['https://res.cloudinary.com/dqjzulqyf/image/upload/v1623025062/Baiku/D3B626F4-FAFD-43FB-963B-A039A5BF5C35_d93gp6.jpg',
              'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623025062/Baiku/6183C6A0-E4BB-4A5E-8D4F-A95BA744AE77_ohi8wu.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623025061/Baiku/7BF92020-FFBA-46B7-B9D3-5788CB0E7EDB_utkfru.jpg',
              'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623025061/Baiku/282F6206-295E-406C-83A1-A505C964380D_tu7zsn.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623025061/Baiku/1F97E027-531B-45A2-9064-873A90FE748D_icopks.jpg',
              'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623025061/Baiku/3322080E-DA65-476F-9AB5-11FB684F657E_wlfkby.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623025061/Baiku/59911A1B-F966-45FB-938E-80AB40703D27_gtqr8i.jpg',
              'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623025061/Baiku/1C080CEA-F49E-4EAA-A4DE-99CB2D200900_nzqlmo.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623025060/Baiku/31623B52-C231-4544-A63F-F940466F6CA0_wpnvyd.jpg',
              'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623025060/Baiku/560D1042-DBAD-4B74-8E14-9D5F58164E60_cqkszs.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623025060/Baiku/C6B0282A-3C3B-4255-9420-5BBE547CB541_modma7.jpg',
              'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623025060/Baiku/7884D7D7-82D7-4E75-A6E0-ED05E54BC366_ocy6j3.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623025059/Baiku/B1432338-ADC3-4267-9ACA-491BD4CDA05F_qokltr.jpg',
              'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623025059/Baiku/IMG_20210606_140711_svchqc.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623025059/Baiku/7F23D651-64E1-4B25-9378-009632192E32_zzrf1b.jpg',
              'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623025058/Baiku/A8882A27-58C1-41C2-880F-790D26696CF1_lfdvxs.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623025058/Baiku/IMG_20210606_140433_ci4lfm.jpg',
              'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623025058/Baiku/08ECAD2C-BD86-48D6-A8E6-28CE6B5D87EC_g46omk.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623025058/Baiku/E45E125D-B2E9-4CC1-9B78-FCB61BA7E656_t2kyif.jpg',
              'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623025057/Baiku/65560008-E2C3-47D0-A535-7E84F08A11F1_qwihxt.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623025057/Baiku/IMG_20210606_140439_npgtgs.jpg',
              'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623025057/Baiku/7A675F15-EB87-4869-88DD-728C35886E9A_ap8qx5.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623025056/Baiku/C4A26AEB-810B-4B15-9966-85ECD5AFB112_f6mp0o.jpg',
              'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623025056/Baiku/0D8A8C16-49C2-42F9-B2EC-FA06A8320E09_a8igkw.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623025056/Baiku/763C5461-5C63-46D3-86EF-540AA9B59A83_h74xs3.jpg',
              'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623025056/Baiku/B54E93E3-A0B5-4AF2-9CEF-F229F0214DD6_wf3rdo.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623025052/Baiku/IMG_20210606_140746_q91i27.jpg',
              'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623025051/Baiku/IMG_20210606_142545_ceb1ne.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623025050/Baiku/IMG_20210606_140741_z5yg4k.jpg',
              'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024838/Baiku/B831FF3D-5350-4541-95B5-4D2E138E93FD_g9k50r.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024837/Baiku/D92C4450-FB81-47DE-9692-38AFC0DC5394_lqhdff.jpg',
              'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024837/Baiku/89EE4448-1423-4062-B81B-03A2C1F95369_faodxw.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024836/Baiku/8A0F56D9-C7C5-4CD3-A853-7028D24584C1_arsbmn.jpg',
              'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024835/Baiku/89B28167-ACFF-45D0-8174-BB9EBC2A234C_wtm3xt.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024835/Baiku/527FA4B5-4853-4E22-A694-C44E8E5E7D81_eltgob.jpg',
              'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024835/Baiku/AB5F23F6-63D8-41A1-891A-C2FE75137DB2_scy6uu.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024833/Baiku/2E773E55-234A-4C31-AB87-0DFFAB9B5B01_jh2wrv.jpg',
              'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024832/Baiku/A0DBB797-4727-4CE1-AFC5-22BF566C06C6_cl0mty.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024832/Baiku/BC1F58FB-A263-4396-ABAF-DAD84DDC4CD8_bp4kob.jpg',
              'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024831/Baiku/3E668549-012D-4755-90F3-F5A9639446D3_a89abe.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024831/Baiku/144E3EFC-3B24-4D25-B6A2-599CC9ED6568_e4rmov.jpg',
              'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024828/Baiku/AD5F7AB7-CCC7-40A5-9FFD-61DF36462077_f9hyvy.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024828/Baiku/4BACF4F7-408E-45E5-A3E5-137E8AA146E2_xdaze2.jpg',
              'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024827/Baiku/19848F52-5515-472C-B040-5CAB244A3488_h9ouol.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024827/Baiku/3814239D-011C-4BA8-88E7-14CF8A51BC4C_nhsi9f.jpg',
              'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024825/Baiku/879DBF8E-1DA4-4E91-B5A3-DEF7B069CAE8_q4xuhz.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024824/Baiku/009A8445-CA1F-4EBD-8929-B0D9FF483147_anmv3x.jpg',
              'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024824/Baiku/9442BF0D-EE0F-4383-AE7C-488FAD7C6A8F_ffskev.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024823/Baiku/8E359BD8-4D2A-4F93-BAB8-45BDF8E32EAA_e2ktz8.jpg',
              'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024823/Baiku/9CC2EBB9-2CE6-4A2F-A16A-93B74D75C776_pufygb.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024821/Baiku/EE4D861E-9246-49B8-99C9-E923D91C18FA_d0slrh.jpg',
              'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024820/Baiku/042B6CF1-1BB9-4674-92D3-E19E468D6107_plqhxx.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024236/Baiku/20_dvrjp6.jpg',
              'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024236/Baiku/19_qgknyr.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024235/Baiku/18_er1ng0.jpg',
              'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024235/Baiku/16_xftz3j.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024235/Baiku/14_uitqc3.jpg',
              'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024235/Baiku/17_vb0fx8.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024235/Baiku/11_yjgerg.jpg',
              'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024235/Baiku/15_ba2gap.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024235/Baiku/13_deevqm.jpg',
              'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024235/Baiku/12_yqe48i.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024235/Baiku/8_zxxyiz.jpg',
              'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024235/Baiku/10_o6zsbh.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024234/Baiku/9_tsvpdu.jpg',
              'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024234/Baiku/7_ercngl.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024234/Baiku/3_dwyzlz.jpg',
              'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024234/Baiku/5_yfwwss.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024234/Baiku/1_xhfhji.jpg',
              'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024234/Baiku/2_lsbrqx.jpg', 'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024234/Baiku/6_niahhy.jpg',
              'https://res.cloudinary.com/dqjzulqyf/image/upload/v1623024234/Baiku/4_exoeov.jpg']

    description = ['Free for members', 'Free for customers', 'Quiet area near the a training center', 'Small street. Cafe and river nearby', 'Lots of parking spaces',
                   'Next to Otori-jinja', 'Free for customers', 'Quiet street behind Family Mart. Free for customers', 'Free for customers', "Quiet residential area. Mainly seniors that don't say much",
                   'Free for customers', 'Small street near Mita Okanoue Park', 'Free for customers', 'Opposite a photography studio', 'Free for customers', 'Next to an academy. Plenty of space',
                   'This spot is on a side street in front of Hoshino building (south side) close to Meguro station. Few bikes are usually parked here. Used it several times during the day without any issues.']


    document.search('Placemark').first(50).each_with_index do |coordinates, index|

      idx_descrip = rand(0...description.count)
      idx = rand(images.count)
      file = URI.open(images[idx])
      name = coordinates.search('name').text.strip.include?("/") ? coordinates.search('name').text.strip.split("/")[1].strip : coordinates.search('name').text.strip
      p name
      longitude = coordinates.search('coordinates').text.strip.split(",")[0].to_f
      p longitude
      latitude = coordinates.search('coordinates').text.strip.split(",")[1].to_f
      p latitude
      parking = Parking.create(name: name, latitude: latitude, longitude: longitude, price: rand(0..1), risk_level: 0, description: description[idx_descrip])
      parking.photos.attach(io: file, filename: 'parking.jpg', content_type: 'image/jpg')
      sleep(2)

      puts "Created #{Parking.count} parkings!"
    end
  end
end
