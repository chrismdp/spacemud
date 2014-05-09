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
    it "returns http success" do
      get 'game'
      response.should be_success
    end
  end

  describe "GET 'move'" do
    it "returns http success" do
      get 'move'
      response.should be_success
    end
  end

end
