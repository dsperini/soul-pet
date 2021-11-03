# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Adoption.destroy_all
# Pet.destroy_all
# User.destroy_all
require 'faker'

5.times do 
  user = User.create!(
    email: Faker::Internet.email,
    password: "123123"
  )

  puts "The user #{user.id} created"
  puts '-----------------------------'
  puts "Uploading some products to user..."
  puts '-----------------------------'


  10.times do 
    file = URI.open('https://source.unsplash.com/featured/?pet')
    
    pet = Pet.create!(
      user_id: user.id,
      name: Faker::Creature::Dog.name,
      age: (1..20).to_a.sample,
      breed: ['cão', 'gato', 'passarinho'].sample,
      size: ['pequeno', 'médio', 'grande'].sample

    )
    pet.photo.attach(io: file, filename: 'photo.png', content_type: 'image/png')
    
    puts "The dog #{pet.id}"
  end
end
puts "fim"
