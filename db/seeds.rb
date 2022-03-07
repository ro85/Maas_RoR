# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all

admin = User.new(name:"Rodrigo", admin:true, email:"admin@mail.com", password:"123456")
admin.save!
p admin

ernesto = User.new(name:"Ernesto", email:"ernesto@mail.com", password:"123456")
ernesto.save!
p ernesto

barbara = User.new(name:"Bárbara", email:"barbara@mail.com", password:"123456")
barbara.save!
p barbara

benjamin = User.new(name:"Benjamín", email:"benjamin@mail.com", password:"123456")
benjamin.save!
p benjamin

if Weekday.count != 7
  Weekday.destroy_all
  d = Weekday.new(weekday:"Domingo")
  d.save!
  p d

  l = Weekday.new(weekday:"Lunes")
  l.save!
  p l

  ma = Weekday.new(weekday:"Martes")
  ma.save!
  p ma

  mie = Weekday.new(weekday:"Miercoles")
  mie.save!
  p mie

  j = Weekday.new(weekday:"Jueves")
  j.save!
  p j

  v = Weekday.new(weekday:"Viernes")
  v.save!
  p v

  s = Weekday.new(weekday:"Sabado")
  s.save!
  p  s
end

