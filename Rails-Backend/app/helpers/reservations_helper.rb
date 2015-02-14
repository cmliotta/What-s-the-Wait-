module ReservationsHelper

  def find_reservation
    @reservation = Reservation.find(params[:id])
  end

end
