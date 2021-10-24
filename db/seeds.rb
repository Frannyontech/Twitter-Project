# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
users = User.all

50.times do |i|
    User.create(
        name: Faker::Name.name,  
        password: 123456,
        profile_url: "https://gravatar.com/avatar/b39415723529a102c24cfc0d823fb024?s=400&d=robohash&r=x",
        email: "example#{i+1}@mail.cl" 
    )
end

50.times do |i|
    Tweet.create(
        content: "Soy el Tweet nro #{i + 1}",
        user_id: rand(1..10)
    )
end

