class ReservationsController < ApplicationController
  def index
    restaurant = Restaurant.find(:restaurant_id)
    reservations = restaurant.reservations
    render json: reservations
  end

  def show
    patron = Patron.find_by(:patron_id)
    reservation = patron.reservation
    render json: reservation
  end

  def create
    reservation = Reservation.new(reservation_params)
    if reservation.save
      render json: reservation
    else
      render json: "Please check your entries"
    end
  end

  def update
    reservation = Reservation.find(:id)
    reservation.update(reservation_params)
    if reservation.save
      render json: reservation
    else
      render json: "Please check your edited entries"
    end
  end

  def destroy
    reservation = Reservation.find(:id)
    reservation.destroy
  end

  private
    def reservation_params
      params.require(:reservation).permit(:restaurant_id, :patron_id, :party_size, :minutes)
    end
end
