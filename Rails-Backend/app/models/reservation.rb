class Reservation < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :patron

  validates_presence_of :restaurant_id, :patron_id, :party_size, :minutes
  before_save :add_patron_name

  def add_patron_name
    self.first_name = self.patron.first_name
    self.last_initial = self.patron.last_name[0]
  end
end
