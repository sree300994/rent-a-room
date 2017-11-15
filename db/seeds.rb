# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Role.create(name: "admin")
# Role.create(name: "host")
# Role.create(name: "guest")






user = User.create!(:email => "admin@gmail.com", :password => "secret123", :password_cofirmation => "secret123", :username => "admin", :role_id => Role.find_by(:name => "admin").id)
puts "user created with admin role"
