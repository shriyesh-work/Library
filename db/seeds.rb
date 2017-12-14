# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(firstname: 'Jon', lastname: 'Doe', email: 'jondoe@anonymous.com', password: 'jondoe123', is_admin: true)
User.create(firstname: 'Rahul', lastname: 'Joshi', email: 'rahul@gmail.com', password: 'rahul123', is_admin: false)

Book.create(name: 'Alice in Wonderland', author: 'Lewis Carroll', isbn: 9781533345455, category: 'Fiction')