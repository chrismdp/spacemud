class GameController < ApplicationController
  before_filter :find_player, except: :index

  def index
    @player = Player.new
  end

  def game
  end

  def move
    destination = Location.find_by_id(params[:destination_location_id])
    if (destination.nil?)
      flash[:error] = "That destination does not exist!"
    elsif (@player.location.exits.any? { |e| e.destination == destination })
      @player.update_attributes!(location_id: params[:destination_location_id])
    else
      flash[:error] = "You cannot move to that location from here"
    end
    redirect_to game_path
  end

  private

  def find_player
    @player = Player.find_by_id(session[:player_id])
    redirect_to root_path unless @player
  end
end
