module ReservationsHelper

  def find_reservation
    @reservation = Reservation.find(params[:id])
  end

  def select_reservations(party_size)
    @restaurant = Restaurant.find(params[:restaurant_id])
    @reservations = []
    if party_size == 2
      @reservations << Reservation.where(restaurant_id: @restaurant.id, party_size: 1)
      @reservations << Reservation.where(restaurant_id: @restaurant.id, party_size: 2)
    else
      @reservations << Reservation.where(restaurant_id: @restaurant.id, party_size: 3)
      @reservations << Reservation.where(restaurant_id: @restaurant.id, party_size: 4)
    end
  end

end
