# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(name:  "stefano",
             admin:                 true,
             password:              "password",
             password_confirmation: "password")

5.times do |n|
  name  = Faker::Name.name
  password = "password"
  User.create!(name:  name,
               password:              password,
               password_confirmation: password)
end

Store.create!(place: "Campus Universitario Ecotekne, Monteroni")

20.times do |n|
  place  = "#{Faker::Address.street_name} #{Faker::Address.building_number}, #{Faker::Address.city}"
  Store.create!(place: place)
end

2.times do |n|
  name  = Faker::Commerce.department(1)
  Category.create!(name: name)
end

category = Category.take
store = Store.take

5.times do |n|
    Product.create!(name: Faker::Commerce.product_name, price: Faker::Commerce.price, stores: [store], category: category)
end