require 'rails_helper'

describe ReservationsController  do
  before :each do

    Restaurant.delete_all

    @restaurant = Restaurant.create(first_name: "Chris", last_name: "Bo", restaurant_name: "Bennys", email: "a@a.com", city: "reno", state: "nv", zip:"2323", phone: "232", password: "hi")

    @reservation = Reservation.create(restaurant_id: 1, patron_id: 1, party_size: 4, minutes: 30)

    @patron = Patron.create(first_name: "Jan", last_name:"Koller", cell_phone: "1313", email:"b@b.com", password: "1213")
  end

  describe "GET #index" do
    it "returns 200 status" do
      get :index, restaurant_id: @restaurant.id
      expect(response.status).to be(200)
    end
  end

  describe "#show" do
    it "includes the wait time" do
      get(:show, restaurant_id: @restaurant.id, id: @reservation.id)
      expect(response.body).to include("30")
    end
  end

  describe "#destroy" do
    it "destroys the reservation" do
      expect{
        delete(:destroy, restaurant_id: @restaurant.id, id: @reservation.id)
      }.to change(Reservation, :count).by(-1)
    end
  end

  describe "#create" do
    it "creates a new reservation" do
      expect{
        post(:create, restaurant_id: 2, reservation: {restaurant_id: 2, patron_id: 1, party_size: 3, minutes: 10})
      }.to change(Reservation, :count).by(1)
    end
  end

  describe "#update" do
    it "updates the reservation" do
      put :update, restaurant_id: @restaurant.id, id: @reservation.id, reservation: { party_size: 3, minutes: 40 }
      @reservation.reload
      expect(@reservation.minutes).to eq(40)
    end
  end

  describe "#add_time_3_or_4" do
    it "adds 5 minutes to all reservations of 3/4" do
      initial_time = @reservation.minutes
      put :add_time_3_or_4, restaurant_id: @restaurant.id
      @reservation.reload
      expect(@reservation.minutes).to eq(initial_time + 5)
    end
  end

  describe "#subtract_time_3_or_4" do
    it "subtracts 5 minutes to all reservations of 3/4" do
      initial_time = @reservation.minutes
      put :subtract_time_3_or_4, restaurant_id: @restaurant.id
      @reservation.reload
      expect(@reservation.minutes).to eq(initial_time - 5)
    end
  end

   describe "#add_time_1_or_2" do
    it "adds 5 minutes to all reservations of 1/2" do
      initial_time = @reservation.minutes
      put :add_time_1_or_2, restaurant_id: @restaurant.id
      @reservation.reload
      expect(@reservation.minutes).to be(initial_time)
    end
  end

  describe "#subtract_time_1_or_2" do
    it "subtracts 5 minutes to all reservations of 3/4" do
      initial_time = @reservation.minutes
      put :subtract_time_1_or_2, restaurant_id: @restaurant.id
      @reservation.reload
      expect(@reservation.minutes).to eq(initial_time)
    end
  end

end