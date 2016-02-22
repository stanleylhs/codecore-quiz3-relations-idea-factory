# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

5.times do
  u = User.create first_name: Faker::Name.first_name,
               last_name:  Faker::Name.last_name,
               email:      Faker::Internet.free_email
  5.times do
    u.ideas.create title: Faker::Company.bs,
                     body:  Faker::Lorem.paragraph
  end
                   # password: Faker::Internet.password
end