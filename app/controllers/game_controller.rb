class GameController < ApplicationController
  def index
    @player = Player.new
  end

  def game
    @player = Player.find_by_id(session[:player_id])
    redirect_to root_path unless @player
  end

  def move
    @player = Player.find_by_id(session[:player_id])
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
end
