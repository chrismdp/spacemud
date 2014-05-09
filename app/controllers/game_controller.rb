class PlayerMover < Struct.new(:controller)
  def move(player, location_id)
    unless (destination = Location.find_by_id(location_id))
      controller.flash[:error] = "That destination does not exist!"
      controller.redirect_to controller.game_path
      return
    end

    if (player.location.exits.any? { |e| e.destination == destination })
      player.update_attributes!(location_id: location_id)
    else
      controller.flash[:error] = "You cannot move to that location from here"
    end
    controller.redirect_to controller.game_path
  end
end

class GameController < ApplicationController
  before_filter :find_player, except: :index

  def index
    @player = Player.new
  end

  def game
  end

  def move
    PlayerMover.new(self).move(@player, params[:destination_location_id])
  end

  private

  def find_player
    @player = Player.find_by_id(session[:player_id])
    redirect_to root_path unless @player
  end
end
