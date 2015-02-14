class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.integer :restaurant_id
      t.integer :patron_id
      t.integer :party_size
      t.integer :minutes
      t.string :first_name
      t.string :last_initial

      t.timestamps
    end
  end
end
