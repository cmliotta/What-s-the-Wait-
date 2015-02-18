require 'rails_helper'

describe ReservationsController  do
  before :each do

    Restaurant.delete_all

    @restaurant = Restaurant.create(first_name: "Chris", last_name: "Bo", restaurant_name: "Bennys", email: "a@a.com", city: "reno", state: "nv", zip:"2323", phone: "232", password: "hi")

    @patron = Patron.create(first_name: "Jan", last_name:"Koller", cell_phone: "1313", email:"b@b.com", password: "1213")

    @reservation = Reservation.create(restaurant_id: 1, patron_id: 1, party_size: 4, minutes: 30)

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
        post(:create, restaurant_id: @restaurant.id, cell_phone: @patron.cell_phone, reservation: {restaurant_id: @restaurant.id, patron_id: @patron.id, party_size: 3, minutes: 10})
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

  describe "#add_time" do
    it "adds 5 minutes" do
      initial_time = @reservation.minutes
      post :add_time, restaurant_id: @restaurant.id, party_size: @reservation.party_size
      @reservation.reload
      expect(@reservation.minutes).to eq(initial_time + 5)
    end
  end

  describe "#subtract_time" do
    it "subtracts 5 minutes" do
      initial_time = @reservation.minutes
      post :subtract_time, restaurant_id: @restaurant.id, party_size: @reservation.party_size
      @reservation.reload
      expect(@reservation.minutes).to eq(initial_time - 5)
    end
  end

  describe "#countdown" do
    it "subtracts 1 minute" do
      initial_time = @reservation.minutes
      post :countdown, restaurant_id: @restaurant.id, id: @reservation.id
      @reservation.reload
      expect(@reservation.minutes).to eq(initial_time - 1)
    end
  end

  describe "#send_alert" do
    it "send an alert if table_ready is true" do
      @reservation.table_ready = true
      @reservation.save
      get :send_alert, restaurant_id: @restaurant.id, id: @reservation.id
      expect(response.body).to include("ready")
    end
  end

  describe "#cancellation" do
    it "changes cancel_table to true" do
      post :cancellation, restaurant_id: @restaurant.id, id: @reservation.id
      @reservation.reload
      expect(@reservation.cancel_table).to eq("t")
    end
  end

  describe "#check_cancellations" do
    it "includes the name of the cancelee" do
      post :cancellation, restaurant_id: @restaurant.id, id: @reservation.id
      get :check_cancellations, restaurant_id: @restaurant.id
      expect(response.body).to include("Jan K")
    end
  end

end
