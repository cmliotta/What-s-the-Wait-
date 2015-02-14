class ReservationsController < ApplicationController
  include ReservationsHelper

  def index
    restaurant = Restaurant.find(params[:restaurant_id])
    reservations = restaurant.reservations

    render json: reservations
  end

  def show
    find_reservation
    render json: @reservation
  end

  def create
    reservation = Reservation.new(reservation_params)
    patron = Patron.find(reservation.patron_id)
    if reservation.save
      render json: {first_name: patron.first_name, last_initial: patron.last_name[0], party_size: reservation.party_size, wait_time: reservation.minutes}
    else
      render json: "Please check your entries"
    end
  end

  def update
    find_reservation
    @reservation.update(reservation_params)
    patron = Patron.find(@reservation.patron_id)
    if @reservation.save
      render json: {first_name: patron.first_name, last_initial: patron.last_name[0], party_size: @reservation.party_size, wait_time: @reservation.minutes}
    else
      render json: "Please check your edited entries"
    end
  end

  def destroy
    find_reservation
    @reservation.destroy
  end

  def add_time_3_or_4
    @reservations = []
    @reservations << Reservation.where(party_size: 3)
    @reservations << Reservation.where(party_size: 4)
    @reservations.each { |active_record| active_record.each {|reservation| reservation.increment!(:minutes, by = 5)} }

    render json: @reservations
  end

  def subtract_time
    find_reservation
    @reservation.decrement!(:minutes, by = 5)
    render json: @reservation
  end


  private
    def reservation_params
      params.require(:reservation).permit(:restaurant_id, :patron_id, :party_size, :minutes)
    end
end
