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
user = User.create!(:email => "admin@gmail.com",:first_name => "admin", :last_name => "admin", :mobile => 9898989898 , :password => "secret123", :password_confirmation => "secret123", :username => "admin", :role_id => role)
puts "user created with admin role"
