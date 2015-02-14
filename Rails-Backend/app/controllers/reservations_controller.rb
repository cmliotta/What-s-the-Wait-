class ReservationsController < ApplicationController
  include ReservationsHelper

  def index
    restaurant = Restaurant.find(params[:restaurant_id])
    reservations = restaurant.reservations
    p reservations

    render json: reservations
  end

  def show
    find_reservation
    render json: @reservation
  end

  def create
    patron = Patron.find_by(cell_phone: params[:cell_phone])
    reservation = Reservation.new(patron_id: patron.id, restaurant_id: params[:restaurant_id], party_size: params[:party_size], minutes: params[:minutes])
    if reservation.save
      render json: {first_name: patron.first_name, last_initial: patron.last_name[0], party_size: reservation.party_size, minutes: reservation.minutes}
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
    select_reservations_with_3_or_4_party_size
    @reservations.each { |active_record| active_record.each {|reservation| reservation.increment!(:minutes, by = 5)} }

    render json: @reservations
  end

  def subtract_time_3_or_4
    select_reservations_with_3_or_4_party_size
    @reservations.each { |active_record| active_record.each {|reservation| reservation.decrement!(:minutes, by = 5)} }
    render json: @reservations
  end

  def add_time_1_or_2
    select_reservations_with_1_or_2_party_size
    @reservations.each { |active_record| active_record.each {|reservation| reservation.increment!(:minutes, by = 5)} }

    render json: @reservations
  end

  def subtract_time_1_or_2
    select_reservations_with_1_or_2_party_size
    @reservations.each { |active_record| active_record.each {|reservation| reservation.decrement!(:minutes, by = 5)} }
    render json: @reservations
  end

  private
    def reservation_params
      params.require(:reservation).permit(:restaurant_id, :patron_id, :party_size, :minutes)
    end
end
