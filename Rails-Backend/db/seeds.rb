# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

restaurant = Restaurant.create(first_name: 'John', last_name: 'Doe', restaurant_name: 'Johns BBQ')

patron = Patron.create(first_name: 'Jane', last_name: 'Doe', cell_phone: "555-555-5555")

reservation = Reservation.create(restaurant_id: 1, patron_id: 1, minutes: 30, party_size: 4)
