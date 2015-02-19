restaurant = Restaurant.create(first_name: 'John', last_name: 'Doe', restaurant_name: "John's BBQ", email: 'g@g.com', city: "sf", state: "ca", zip: "94591", phone: "707-707-7007", password: "food")

patron = Patron.create(first_name: 'Sherif', last_name: 'Abushadi', cell_phone: "222-222-2222", email: "j@j.com", password: "food")
patron2 = Patron.create(first_name: 'Derek', last_name: "Reeve", cell_phone: "777-777-7777", email: "e@e.com", password: "food")
patron3 = Patron.create(first_name: 'Jen', last_name: "Gilbert", cell_phone: "333-333-3333", email: "a@a.com", password: "food")
patron4 = Patron.create(first_name: 'Jordan', last_name: "Kamin", cell_phone: "555-555-5555", email: "c@c.com", password: "food")

reservation2 = Reservation.create(restaurant_id: 1, patron_id: 2, minutes: 10, party_size: 2)
reservation3 = Reservation.create(restaurant_id: 1, patron_id: 3, minutes: 20, party_size: 2)
reservation = Reservation.create(restaurant_id: 1, patron_id: 4, minutes: 10, party_size: 3)
