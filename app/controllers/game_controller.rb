class PlayerMover < Struct.new(:controller)
  def move(player, destination)
    unless (destination)
      controller.error("That destination does not exist!")
      return
    end

    if (player.can_move_to?(destination))
      player.move_to!(destination)
      controller.success
    else
      controller.error("You cannot move to that location from here")
    end
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
    PlayerMover.new(self).move(@player, Location.find_by_id(params[:destination_location_id]))
  end

  def error(msg)
    flash[:error] = msg
    redirect_to game_path
  end

  def success
    redirect_to game_path
  end

  private

  def find_player
    @player = Player.find_by_id(session[:player_id])
    redirect_to root_path unless @player
  end
end
