class ReservationsController < ApplicationController
  include ReservationsHelper

  def index
    restaurant = Restaurant.find(params[:restaurant_id])
    reservations = restaurant.reservations.order("created_at ASC")

    render json: {restaurant: restaurant,reservations: reservations}
  end

  def show
    find_reservation
    render json: @reservation
  end

  def create
    patron = Patron.find_by(cell_phone: params[:cell_phone])
    reservation = Reservation.new(patron_id: patron.id, restaurant_id: params[:restaurant_id], party_size: params[:party_size], minutes: params[:minutes])
    if reservation.save
      render json: reservation
    else
      render json: "Please check your entries"
    end
  end

  def update
    find_reservation
    @reservation.update(reservation_params)
    patron = Patron.find(@reservation.patron_id)
    if @reservation.save
      render json: @reservation
    else
      render json: "Please check your edited entries"
    end
  end

  def destroy
    find_reservation
    @reservation.destroy
  end

  def add_time
    select_reservations(params[:party_size])
    @reservations.each { |active_record| active_record.each {|reservation| reservation.increment!(:minutes, by = 5)} }
    # render json: @reservations
  end

  def subtract_time
    select_reservations(params[:party_size])
    @reservations.each { |active_record| active_record.each {|reservation| reservation.decrement!(:minutes, by = 5)} }
    # render json: @reservations
  end

  private
    def reservation_params
      params.require(:reservation).permit(:restaurant_id, :patron_id, :party_size, :minutes)
    end
end
