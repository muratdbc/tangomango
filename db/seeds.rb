require 'faker'

# 5.times do
#   User.create(:username => Faker::Name.first_name, :email => Faker::Internet.email, :password => Faker::Lorem.word)
# end

# #test user
# User.create(:username => "test_user", :email => "test@gmail.com", :password => "pass")



["19 Heron Street",
"295 Day St",
"351 Shotwell Street",
"404 Clement St.",
"455A Valencia Street",
"710 Florida Street",
"768 Brannan St",
"830 17th St.",
"1153 Valencia Street",
"1270 Sutter St.",
"1275 Connecticut street",
"1532 Taravel Street",
"1800 Market Street",
"1830 17th Street",
"1900 Geary Blvd.",
"2050 Bryant St.",
"2101 Mariposa St.",
"2460 Sutter St",
"2565 Mission St.",
"2837 Claremont Blvd.",
"2868 Mission Street",
"2840 Mariposa Street",
"3971 26th Street"].each  do |t|
  @event=Event.new
  sleep(2)
  area=["contro_costa","humboldt","marin","mendocino","monterey","south_bay","san_francisco","east_bay"].sample()
  event_type=["milongas","drop_in_classes","worskops","practicas","live_music","performances"].sample()
  @event.createWithGeo(:area => area,:event_type =>event_type,:title => Faker::Lorem.sentence(3),:address =>t,:city =>"sf",:state=>"ca",:date => ((Date.today.beginning_of_week) + (0..13).to_a.sample()).to_s)

end
# ["2050 Bryant St.",
# "19 Heron Street",
# "768 Brannan St"
# "1270 Sutter St.",
# "1275 Connecticut",
# "404 Clement St.",
# "1532 Taravel Street",
# "455A Valencia Street",
# "1800 Market Street",
# "351 Shotwell Street",
# "1153 Valencia Street",
# "351 Shotwell Street",
# "710 Florida Street"]
# 20.times do
#   @event=Event.new
#   @event.createWithGeo(title: => Faker::Lorem.sentence(3),date: =>(Date.today + [1,2,3,4,5,6,7].sample()).to_s, )

#  Event(id: integer, title: string, date: date, address: string, city: string, state: string, zipcode: integer, latitude: decimal, longtitude: decimal)