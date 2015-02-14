require 'rails_helper'

describe ReservationsController  do
  before :each do
    Restaurant.delete_all
    @restaurant = Restaurant.create(first_name: "Chris", last_name: "Bo", restaurant_name: "Bennys", email: "a@a.com", city: "reno", state: "nv", zip:"2323", phone: "232", password: "hi")

    @reservation = Reservation.create(restaurant_id: 1, patron_id: 1, party_size: 4, minutes: 30)
  end

  describe "GET #index" do
    it "returns 200 status" do
      get :index, restaurant_id: @restaurant.id
      expect(response.status).to be(200)
    end
  end

  describe "#show" do
    it "renders json" do
      get(:show, restaurant_id: @restaurant.id, id: @reservation.id)
      expect(response.body).to include("")
    end
  end

  # describe "#destroy" do
  #   it "destroys the question" do
  #     expect{
  #       delete(:destroy, 'id' => question.id)
  #     }.to change(Question, :count).by(-1)
  #   end
  # end

  # describe "#create" do
  #   it "creates the question" do
  #     expect{
  #       post(:create, question: {title: question.title, content: question.content})
  #     }.to change(Question, :count).by(1)
  #   end
  # end

  # describe "#edit" do
  #   it "renders edit template" do
  #     get(:edit, {'id' => question.id})
  #     expect(response).to render_template(:edit)
  #   end
  # end

  # describe "#update" do
  #   it "changes the title of the question" do
  #     # attrs = {title: "new title", content: "new content"}
  #     # put :update, 'id' => question.id, question: attrs
  #     put :update, id: question.id, question: { title: "new title", content: "new content" }
  #     question.reload
  #     expect(question.title).to eq("new title")
  #   end
  # end

  # describe "#upvote" do
  #   it "incements the vote_count by 1 when action is hit" do
  #     initial = question.vote_count
  #     post :upvote, id: question.id
  #     question.reload

  #     expect(question.vote_count).to eq(initial+1)
  #   end
  # end

  # describe "#downvote" do
  #   it "decements the vote_count by 1 when action is hit" do
  #     initial = question.vote_count
  #     post :downvote, id: question.id
  #     question.reload

  #     expect(question.vote_count).to eq(initial-1)
  #   end
  # end

end