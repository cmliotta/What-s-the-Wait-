class PatronsController < ApplicationController
  def create
    patron = Patron.new(patron_params)

    if patron.save
      render json: patron
    else
      render json: "Please enter your data better"
    end
  end

  def update
    patron = Patron.find(:id)
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
