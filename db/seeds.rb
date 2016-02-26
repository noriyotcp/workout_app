# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.delete_all
Exercise.delete_all

puts "Generating seed data..."
# User for login
FactoryGirl.create(:user, { first_name: 'For', last_name: 'Login', email: 'login@example.com', password: 'password' })
FactoryGirl.create_list(:exercise, 100) # Also create the associated users
puts "Done."
