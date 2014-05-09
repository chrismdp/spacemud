require 'spec_helper'

describe GameController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
      assigns(:player).should be_a_new(Player)
    end
  end

  describe "GET 'game'" do
    let(:player) { Player.create(name: "Joe Jenson") }

    it 'finds the right player' do
      get 'game', {}, {player_id: player.id}
      assigns(:player).should eq(player)
    end

    it 'redirects to the index if you have no player id' do
      get 'game'
      response.should redirect_to(root_path)
    end
  end

  describe "GET 'move'" do
    let(:player) { Player.create(name: "Joe Jenson") }
    let(:location) { Location.create(name: "start") }
    let(:destination) { Location.create(name: "destination") }
    let(:disconnected) { Location.create(name: "somewhere else") }

    before do
      location.exits << Exit.new(location_id: location.id, destination_location_id: destination.id)
      player.update_attribute(:location_id, location.id)
    end

    it 'moves the player to the new location' do
      post 'move', {destination_location_id: destination.id}, {player_id: player.id}
      assigns(:player).location_id.should eq(destination.id)
    end

    it 'redirects to the game again' do
      post 'move', {destination_location_id: destination.id}, {player_id: player.id}
      response.should redirect_to(game_path)
    end

    it 'does not do anything if there is no exit' do
      post 'move', {destination_location_id: disconnected.id}, {player_id: player.id}
      assigns(:player).location_id.should eq(1)
    end
  end

end
