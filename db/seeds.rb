# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

WeekdaySetup.destroy_all
Contract.destroy_all
User.destroy_all


admin = User.new(name:"Rodrigo", admin:true, email:"admin@mail.com", password:"123456", dev: false)
admin.save!
p admin

ernesto = User.new(name:"Ernesto", email:"ernesto@mail.com", password:"123456", dev: true)
ernesto.save!
p ernesto

barbara = User.new(name:"Bárbara", email:"barbara@mail.com", password:"123456", dev: true)
barbara.save!
p barbara

benjamin = User.new(name:"Benjamín", email:"benjamin@mail.com", password:"123456", dev: true)
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

# contract = Contract.new(client_name: "recorrido.cl")
# contract.save!
# p contract

# weekday_setup1 = WeekdaySetup.new(weekday_id:1 , start_of_monitoring: "10:00", end_of_monitoring: "00:00", contract_id: contract.id)
# weekday_setup1.save!
# p weekday_setup1

# weekday_setup2 = WeekdaySetup.new(weekday_id:2 , start_of_monitoring: "19:00", end_of_monitoring: "00:00", contract_id: contract.id)
# weekday_setup2.save!
# p weekday_setup2

# weekday_setup3 = WeekdaySetup.new(weekday_id:3 , start_of_monitoring: "19:00", end_of_monitoring: "00:00", contract_id: contract.id)
# weekday_setup3.save!
# p weekday_setup3

# weekday_setup4 = WeekdaySetup.new(weekday_id:4 , start_of_monitoring: "19:00", end_of_monitoring: "00:00", contract_id: contract.id)
# weekday_setup4.save!
# p weekday_setup4

# weekday_setup5 = WeekdaySetup.new(weekday_id:5 , start_of_monitoring: "19:00", end_of_monitoring: "00:00", contract_id: contract.id)
# weekday_setup5.save!
# p weekday_setup5

# weekday_setup6 = WeekdaySetup.new(weekday_id:6 , start_of_monitoring: "19:00", end_of_monitoring: "00:00", contract_id: contract.id)
# weekday_setup6.save!
# p weekday_setup6

# weekday_setup7 = WeekdaySetup.new(weekday_id:7 , start_of_monitoring: "10:00", end_of_monitoring: "00:00", contract_id: contract.id)
# weekday_setup7.save!
# p weekday_setup7
