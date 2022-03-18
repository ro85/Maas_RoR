# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Contract.destroy_all
User.destroy_all


admin = User.new(name:"Rodrigo", admin:true, email:"admin@mail.com", password:"123456", dev: false)
admin.colour = admin.select_colour
admin.save!
p admin

ernesto = User.new(name:"Ernesto", email:"ernesto@mail.com", password:"123456", dev: true)
ernesto.colour = "#C65314"
ernesto.save!
p ernesto

barbara = User.new(name:"Bárbara", email:"barbara@mail.com", password:"123456", dev: true)
barbara.colour = "#89133E"
barbara.save!
p barbara

benjamin = User.new(name:"Benjamín", email:"benjamin@mail.com", password:"123456", dev: true)
benjamin.colour = "#485856"
benjamin.save!
p benjamin