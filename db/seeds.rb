# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Role.create(name: "admin")
Role.create(name: "host")
Role.create(name: "guest")

role = Role.find_by(:name => "admin").id
user = User.create!(:email => "admin@gmail.com",:first_name => "admin", :last_name => "admin", :mobile => 9898989898 , :password => "123456", :password_confirmation => "123456", :username => "admin", :role_id => role)
puts "user created with admin role"

Amenity.create(name: "Kitchen", description: "A kitchen is a room or part of a room used for cooking and food preparation in a dwelling or in a commercial establishment. In the West, a modern residential kitchen is typically equipped with a stove, a sink with hot and cold running water, a refrigerator, counters and kitchen cabinets arranged according to a modular design.")

Amenity.create(name: "Washing Machine", description: "A washing machine (laundry machine, clothes washer, or washer) is a machine used to wash laundry, such as clothing and sheets. The term is mostly applied to machines that use water as opposed to dry cleaning (which uses alternative cleaning fluids, and is performed by specialist businesses) or ultrasonic cleaners.")

Amenity.create(name: "Water Geyser", description: "Water heating is a heat transfer process that uses an energy source to heat water above its initial temperature. Typical domestic uses of hot water include cooking, cleaning, bathing, and space heating. In industry, hot water and water heated to steam have many uses.")

Amenity.create(name: "WiFi", description: "Devices that can use Wi-Fi technology include personal computers, video-game consoles, phones and tablets, digital cameras, smart TVs, digital audio players and modern printers. Wi-Fi compatible devices can connect to the Internet via a WLAN and a wireless access point. Such an access point (or hotspot) has a range of about 20 meters (66 feet) indoors and a greater range outdoors.")

Amenity.create(name: "Air Conditioning", description: "Air conditioning (often referred to as AC, or A/C) is the process of removing heat from the interior of an occupied space, to improve the comfort of occupants. Air conditioning can be used in both domestic and commercial environments.")

City.create(name: "Kadapa")

City.create(name: "Bangalore")

City.create(name: "Hyderabad")

City.create(name: "Munnar")

City.create(name: "Mumbai")



