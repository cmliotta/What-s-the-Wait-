class Reservation < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :patron

  validates_presence_of :restaurant_id, :patron_id, :party_size, :minutes
end
