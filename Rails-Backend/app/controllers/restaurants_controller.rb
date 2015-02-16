require 'dotenv'
require 'jwt'

class RestaurantsController < ApplicationController
  def create
    restaurant = Restaurant.new(restaurant_params)
    if restaurant.save
      render json: {token: create_token(restaurant)}
    else
      render json: "Please enter your data better"
    end
  end

  def create_token(restaurant)
    Dotenv.load
    secret = ENV['restaurant_secret']
    JWT.encode(restaurant, secret)
  end

  def signin
    restaurant = Restaurant.find_by(email: params[:email])
    if restaurant.authenticate(params[:password])
      render json: {token: create_token(restaurant), id: restaurant.id}
    else
      render json: {error: 'Bad credentials'}, status: :unauthorized
    end
  end

  def create
    restaurant = Restaurant.new(restaurant_params)
    if restaurant.save
      session[:current_restaurant_id] = restaurant.id
      render json: restaurant
    else
      render json: "Please check your entries."
    end
  end

  def update
    restaurant = Restaurant.find(params[:id])
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

  def current_restaurant
    @current_restaurant ||= session[:current_restaurant_id] &&
      restaurant.find_by(id: session[:current_restaurant_id])
  end

end
