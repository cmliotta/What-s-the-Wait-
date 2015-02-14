class ReservationsController < ApplicationController
  def index
    restaurant = Restaurant.find(params[:restaurant_id])
    reservations = restaurant.reservations
    render json: reservations
  end

  def show
    reservation = Reservation.find(params[:id])
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
    reservation = Reservation.find(params[:id])
    reservation.update(reservation_params)
    if reservation.save
      render json: reservation
    else
      render json: "Please check your edited entries"
    end
  end

  def destroy
    reservation = Reservation.find(params[:id])
    reservation.destroy
  end

  private
    def reservation_params
      params.require(:reservation).permit(:restaurant_id, :patron_id, :party_size, :minutes)
    end
end
