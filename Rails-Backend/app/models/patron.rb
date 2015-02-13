class Patron < ActiveRecord::Base
  has_one :reservation
end
