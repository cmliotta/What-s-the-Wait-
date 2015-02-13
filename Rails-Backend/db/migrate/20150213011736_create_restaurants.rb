class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :restaurant_name
      t.string :password_hash
      t.string :city
      t.string :state
      t.integer :zip
      t.string :phone

      t.timestamps
    end
  end
end
