require 'dotenv'

class PatronsController < ApplicationController
  def create
    patron = Patron.new(patron_params)
    if patron.save
      render json: {token: create_token(patron)}
    else
      render json: "Please enter your data better"
    end
  end

  def create_token(patron)
    Dotenv.load
    secret = ENV['patron_secret']
    JWT.encode(patron, secret)
  end

  def signin
    patron = Patron.find_by(cell_phone: params[:cell_phone])
    if patron.authenticate(params[:password])
      render json: {token: create_token(patron), id: patron.id}
    else
      render json: {error: 'Bad credentials'}, status: :unauthorized
    end
  end

  def show
    patron = Patron.find(params[:id])
    reservation = patron.reservation
    restaurant = reservation.restaurant
    render json: {first_name: patron.first_name, last_initial: patron.last_name[0], party_size: reservation.party_size, wait_time: reservation.minutes, restaurant_name: restaurant.restaurant_name, restaurant_phone: restaurant.phone}
  end

  def update
    patron = Patron.find(params[:id])
    patron.update(patron_params)
    if patron.save
      render json: patron
    else
      render json: "error with your updates"
    end
  end

  private

  def patron_params
    params.require(:patron).permit(:first_name, :last_name, :email, :password, :cell_phone)
  end

  def current_patron
    @current_patron ||= session[:current_patron_id] &&
      Patron.find_by(id: session[:current_patron_id])
  end

end
