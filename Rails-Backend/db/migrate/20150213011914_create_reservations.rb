class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.integer :restaurant_id
      t.integer :patron_id
      t.integer :party_size
      t.integer :minutes, default: 10

      t.timestamps
    end
  end
end
