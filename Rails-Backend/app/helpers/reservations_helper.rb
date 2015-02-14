module ReservationsHelper

  def find_reservation
    @reservation = Reservation.find(params[:id])
  end

  def select_reservations_with_3_or_4_party_size
    @restaurant = Restaurant.find(params[:restaurant_id])
    @reservations = []
    @reservations << Reservation.where(restaurant_id: @restaurant.id, party_size: 3)
    @reservations << Reservation.where(restaurant_id: @restaurant.id, party_size: 4)
  end

  def select_reservations_with_1_or_2_party_size
    @restaurant = Restaurant.find(params[:restaurant_id])
    @reservations = []
    @reservations << Reservation.where(restaurant_id: @restaurant.id, party_size: 1)
    @reservations << Reservation.where(restaurant_id: @restaurant.id, party_size: 2)
  end
end
