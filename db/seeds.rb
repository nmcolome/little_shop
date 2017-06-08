# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

class Seeds

  DROIDS = ["#{Rails.root}/app/assets/images/Battle_Droid.png",
            "#{Rails.root}/app/assets/images/astromechs-droid.jpg",
            "#{Rails.root}/app/assets/images/main-qimg_droid.jpeg",
            "#{Rails.root}/app/assets/images/droid_new.jpg",
            "#{Rails.root}/app/assets/images/Repwardroid2.jpg"]

  VEHICLES = ["#{Rails.root}/app/assets/images/ship_1_new.png",
            "#{Rails.root}/app/assets/images/TIEfighter2.png",
            "#{Rails.root}/app/assets/images/ship_2_new.jpg",
            "#{Rails.root}/app/assets/images/AT-AT.png",
            "#{Rails.root}/app/assets/images/MillenniumFalcon.png"]

  POTIONS = ["#{Rails.root}/app/assets/images/Ageing_potion.png",
            "#{Rails.root}/app/assets/images/potion_5.png",
            "#{Rails.root}/app/assets/images/potion_4.png",
            "#{Rails.root}/app/assets/images/potion_3.png",
            "#{Rails.root}/app/assets/images/potion_new.png"]


  def create_users
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
  end

  def create_droids
    category = Category.create(name: "Droids")
    25.times do
      item = category.items.create(title: Faker::StarWars.droid,
                                  description: Faker::StarWars.quote,
                                  price: (40..5000).to_a.sample,
                                  image_att: File.new(DROIDS.sample))
      puts "#{item.title} was created in #{category.name}"
    end
  end

  def create_vehicles
    category2 = Category.create(name: "Vehicles")
    25.times do
      item = category2.items.create(title: Faker::StarWars.vehicle,
                                  description: Faker::StarWars.quote,
                                  price: (40..5000).to_a.sample,
                                  image_att: File.new(VEHICLES.sample))
      puts "#{item.title} was created in #{category2.name}"
    end
  end

  def create_potions
    category3 = Category.create!(name: "Potions")
    25.times do
      item = category3.items.create(title: "Potion of " + Faker::Superhero.power,
                                  description: Faker::Superhero.prefix + " " + Faker::Superhero.suffix,
                                  price: (40..5000).to_a.sample,
                                  image_att: File.new(POTIONS.sample))
      puts "#{item.title} was created in #{category3.name}"
    end
  end

  def create_orders
    20.times do |x|
      user = User.find(x+1)
      3.times do |i|
        order = user.orders.create(status: (0..3).to_a.sample)

        order.items << Item.find((1..75).to_a.sample)
        quantity = (1..5).to_a.sample
        order.order_items.first.update_attribute(:quantity, quantity)
        order.order_items.first.update_attribute(:price_at_purchase, order.items.last.price)

        order.items << Item.find((1..75).to_a.sample)
        quantity = (1..5).to_a.sample
        order.order_items.last.update_attribute(:quantity, quantity)
        order.order_items.last.update_attribute(:price_at_purchase, order.items.last.price)

        puts "Order #{order.id} created for #{user.first_name} #{user.last_name}."
      end
    end
  end

  def populate_database
    create_users
    create_potions
    create_droids
    create_vehicles
    create_orders
  end
end

Seeds.new.populate_database
