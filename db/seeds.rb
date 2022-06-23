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
User.create!(name: "Example Admin",
  email: "example@gmail.com",
  birthday: Date.new(1980, 6, 11),
  password: "venividivici",
  person_id: "0000000",
  password_confirmation: "venividivici")
  
  
User.create!(name: "Example Student",
  email: "example-1@gmail.com",
  birthday: Date.new(2000, 1, 1),
  password: "venividivici",
  person_id: "3000000",
  password_confirmation: "venividivici")
  
  
  
User.create!(name: "Example Lecturer",
  email: "example-2@gmail.com",
  birthday: Date.new(1990, 11, 1),
  password: "venividivici",
  person_id: "6000001",
  password_confirmation: "venividivici")
  
User.create!(name: "Example Program Director",
email: "example-3@gmail.com",
birthday: Date.new(1972, 9, 8),
password: "venividivici",
person_id: "6000002",
password_confirmation: "venividivici")

User.create!(name: "Example Head of School",
email: "example-4@gmail.com",
birthday: Date.new(1970, 3, 7),
password: "venividivici",
person_id: "6000003",
password_confirmation: "venividivici")

User.create!(name: "Example Executive Dean",
email: "example-5@gmail.com",
birthday: Date.new(1960, 2, 10),
password: "venividivici",
person_id: "6000004",
password_confirmation: "venividivici")


User.first.add_role :admin
User.second.add_role :student
User.third.add_role :lecturer
User.fourth.add_role :program_director
User.fifth.add_role :head_of_school
User.find(6).add_role :executive_dean

5.times do |n|
  title = "Testing Title #{n+1} for Lecturer"
  body = "Test"
  completed = false
  escalated = false
  assignee_id = 3
  user_id = 2
  Complaint.create!(title: title,
              body: body,
              completed: completed,
              escalated: escalated,
              assignee_id: assignee_id,
              user_id: user_id
  )
  
end

5.times do |n|
  title = "Testing Title #{n+1} for Program Director"
  body = "Test"
  completed = false
  escalated = false
  assignee_id = 4
  user_id = 2
  Complaint.create!(title: title,
              body: body,
              completed: completed,
              escalated: escalated,
              assignee_id: assignee_id,
              user_id: user_id
  )
  
end

5.times do |n|
  title = "Testing Title #{n+1} for Head of School"
  body = "Test"
  completed = false
  escalated = false
  assignee_id = 5
  user_id = 2
  Complaint.create!(title: title,
              body: body,
              completed: completed,
              escalated: escalated,
              assignee_id: assignee_id,
              user_id: user_id
  )
  
end

5.times do |n|
  title = "Testing Title #{n+1} for Executive Dean"
  body = "Test"
  completed = false
  escalated = false
  assignee_id = 6
  user_id = 2
  Complaint.create!(title: title,
              body: body,
              completed: completed,
              escalated: escalated,
              assignee_id: assignee_id,
              user_id: user_id
  )
  
end


