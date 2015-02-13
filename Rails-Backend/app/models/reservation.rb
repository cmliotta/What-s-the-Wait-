class Reservation < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :patron
end
