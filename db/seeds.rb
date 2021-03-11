# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Type.count == 0
  Type.create(name:'Image', description: 'A still photo')
  Type.create(name:'Film', description: 'A collection of moving pictures')
end

if User.count == 0
  User.create(username:'Admin', password:'password', first_name:'Jared', last_name:'Goldstein', email:'admin@mail.com')
end