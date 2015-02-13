class Restaurant < ActiveRecord::Base
  has_many :reservations

  validates_presence_of :first_name, :last_name, :restaurant_name :email, :city, :state, :zip, :phone, :password

  validates_uniqueness_of :phone, :email

  Valid_Email = /[a-zA-Z0-9.%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}/

  validates :email, format: { with: Valid_Email }

  before :valid?, :check_password_length

  def check_password_length
    [false, "Password is too short!"] if @password.length < 6
  end

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
