# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Product.destroy_all
User.destroy_all

5.times do |i|
  User.create!({
    name: "Usuario#{i+1}",
    email: "ususario#{i+1}@gmail.com",
    password: '1234567890',
    password_confirmation: '1234567890'
    })
end

User.all.each do |user|
  3.times do |i|
    Product.create({
      name: "Producto#{i+1} del usuario #{user.id}",
      description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor. Duis aute irure.",
      price: 30*(i+5)*user.id,
      user_id: user.id
      })
  end
end
