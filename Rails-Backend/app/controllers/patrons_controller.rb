class PatronsController < ApplicationController
  def create
    patron = Patron.new(patron_params)
    if patron.save
      session[:current_patron_id] = patron.id
      render json: patron
    else
      render json: "Please enter your data better"
    end
  end

  def show
    patron = Patron.find(params[:id])
    reservation = patron.reservation
    restaurant = Restaurant.find(reservation.restaurant_id)
    if reservation.party_size <= 2
      parties_ahead = restaurant.reservations.where("party_size = ? AND minutes < ?", 1, reservation.minutes).count
      parties_ahead += restaurant.reservations.where("party_size = ? AND minutes < ?", 2, reservation.minutes).count
    elsif reservation.party_size > 2
      parties_ahead = restaurant.reservations.where("party_size = ? AND minutes < ?", 3, reservation.minutes).count
      parties_ahead += restaurant.reservations.where("party_size = ? AND minutes < ?", 4, reservation.minutes).count
    end
    render json: {waitInfo: reservation, restaurant: restaurant, parties_ahead: parties_ahead}
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
