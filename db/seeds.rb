
Contract.destroy_all
User.destroy_all

admin = User.new(name:"Admin", admin:true, email:"admin@mail.com", password:"123456", dev: false)
admin.colour = admin.select_colour
admin.save!
p admin

dev1 = User.new(name:"Developer", email:"dev@mail.com", password:"123456", dev: true)
dev1.colour = "#C65314"
dev1.save!
p dev1

dev2 = User.new(name:"Developer 2", email:"dev2@mail.com", password:"123456", dev: true)
dev2.colour = "#89133E"
dev2.save!
p dev2

dev3 = User.new(name:"Developer 3", email:"dev3@mail.com", password:"123456", dev: true)
dev3.colour = "#485856"
dev3.save!
p dev3