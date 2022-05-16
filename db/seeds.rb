# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

[:admin, :student, :lecturer, :program_director, :head_of_school, :executive_dean].each do |role|
  Role.create!(name: role)
end


# Create a main sample user.
User.create!(name: "Example Admin ",
  email: "example@gmail.com",
  password: "venividivici",
  password_confirmation: "venividivici")
  
# Generate a bunch of additional users.
5.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@gmail.com"
  password = "venividivici"
  User.create!(name: name,
  email: email,
  password: password,
  password_confirmation: password,
  )
end

#2.times do |n|
  
  #id = n + 1
  
  #User.find(id)
  #User.add_role! :admin

#end

User.first.add_role :admin
User.second.add_role :student
User.third.add_role :lecturer
User.fourth.add_role :program_director
User.fifth.add_role :head_of_school
User.find(6).add_role :executive_dean

