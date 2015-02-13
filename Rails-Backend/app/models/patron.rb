class Patron < ActiveRecord::Base
  has_one :reservation

  validates_presence_of :first_name, :last_name, :cell_phone, :email, :password

  validates_uniqueness_of :cell_phone, :email

  Valid_Email = /[a-zA-Z0-9.%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}/

  validates :email, format: { with: Valid_Email }

  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  def authenticate(password)
    self.password == password
  end
end
