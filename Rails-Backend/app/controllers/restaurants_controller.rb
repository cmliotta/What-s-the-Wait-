class RestaurantsController < ApplicationController
  def create
    restaurant = Restaurant.new(restaurant_params)
    if restaurant.save
      render json: restaurant
    else
      render json: "Please check your entries."
    end
  end

  def update
    restaurant = Restaurant.find(:id)
    restaurant.update(restaurant_params)
    if restaurant.save
      render json: restaurant
    else
      render json: "Please check your edited entries."
    end
  end

  private
  def restaurant_params
    params.require(:restaurant).permit(:first_name, :last_name, :email, :restaurant_name, :password, :city, :state, :zip, :phone)
  end
end
