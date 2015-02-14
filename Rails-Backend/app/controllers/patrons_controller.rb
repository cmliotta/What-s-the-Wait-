class PatronsController < ApplicationController
  def create
    patron = Patron.new(patron_params)
    if patron.save
      render json: patron
    else
      render json: "Please enter your data better"
    end
  end

  def show
    patron = Patron.find(params[:id])
    reservation = patron.reservation
    render json: {first_name: patron.first_name, last_initial: patron.last_name[0], party_size: reservation.party_size, wait_time: reservation.minutes}
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
end
