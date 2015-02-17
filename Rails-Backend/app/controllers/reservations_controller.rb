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
    if patron && reservation.save
      render json: reservation
    else
      render json: [500, {'Content-Type' => 'application/json'}, [{errors: "The phone number does not match any user"}]]
    end
  end

  def update
    find_reservation
    @reservation.update(reservation_params)
    patron = Patron.find(@reservation.patron_id)
    if @reservation.save
      render json: @reservation
    else
      render json: {error: "Please check your edited entries"}
    end
  end

  def destroy
    find_reservation
    @reservation.destroy
  end

  def add_time
    select_reservations(party_size: params[:party_size])
    @reservations.each do |active_record| active_record.each do |reservation|
        reservation.increment!(:minutes, by = 5)
      end
    end
    # render json: @reservations
    p @reservations
  end

  def subtract_time
    select_reservations(party_size: params[:party_size])
    @reservations.each do |active_record|
      active_record.each do |reservation|
        if reservation.minutes > 4
          reservation.decrement!(:minutes, by = 5)
        end
      end
    end
    # render json: @reservations
    p @reservations
  end

  def countdown
    find_reservation
    if @reservation.minutes > 0
      @reservation.decrement!(:minutes)
    end
  end

  def send_alert
    find_reservation
    if request.post?
      @reservation.table_ready = true
      @reservation.save
    end
    if @reservation.table_ready == "t"
      render json: {message: "You're Table is ready"}
    else
      render json: {message: "nothing"}
    end
  end

  private
    def reservation_params
      params.require(:reservation).permit(:restaurant_id, :patron_id, :party_size, :minutes)
    end
end
