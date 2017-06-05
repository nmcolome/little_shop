# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

20.times do
  user = User.create(first_name: Faker::Name.first_name,
              last_name: Faker::Name.last_name,
              username: Faker::Cat.unique.name + ((1..1000).to_a).sample.to_s,
              email: Faker::Internet.unique.email  + ((1..1000).to_a).sample.to_s,
              password: "password",
              address: Faker::Address.street_address,
              city: Faker::Address.city,
              state: Faker::Address.state,
              zipcode: Faker::Address.zip_code)
  puts "You created #{user.username} (who is actually #{user.first_name} #{user.last_name}, email: #{user.email})"
end

admin = User.create(first_name: "admin",
            last_name: "mcadminy",
            username: "admin",
            email: "admin@mcadminy.com",
            password: "password",
            address: Faker::Address.street_address,
            city: Faker::Address.city,
            state: Faker::Address.state,
            zipcode: Faker::Address.zip_code,
            role: 1)
puts "You created an admin!"
