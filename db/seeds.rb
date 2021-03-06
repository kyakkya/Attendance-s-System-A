# coding: utf-8

User.create!(name: "Sample User",
             email: "sample@email.com",
             uid: "1001",
             password: "password",
             password_confirmation: "password",
             admin: true)
             
User.create!(name: "上長A",
             email: "sample-a@email.com",
             uid: "1002",
             password: "password",
             password_confirmation: "password",
             superior: true) 
             
User.create!(name: "上長B",
             email: "sample-b@email.com",
             uid: "1003",
             password: "password",
             password_confirmation: "password",
             superior: true)             

10.times do |n|
  name  = Faker::Name.name
  email = "sample-#{n+1}@email.com"
  password = "password"
  uid = "##{n+1}"
  User.create!(name: name,
               email: email,
               uid: uid,
               password: password,
               password_confirmation: password
              )
end