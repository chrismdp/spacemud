MovedPlayer = Struct.new(:player)
MoveError = Struct.new(:player)

module Reactor
  def process(change)
    send(change.class.to_s.underscore, change)
  end
end

class PlayerMover
  def move(player, destination)
    if (player.can_move_to?(destination))
      MovedPlayer.new(player.move_to(destination))
    else
      MoveError.new(player)
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

  class FileLogger
    include Reactor

    def initialize(log)
      # could be any other service
      @file = File.open(log, "w+")
    end

    def moved_player(change)
      @file.puts("#{change.player.name} moved to #{change.player.location.name}")
      @file.flush
    end

    def move_error(change)
      @file.puts("ERROR: #{change.player.name} smacked his head on a wall")
      @file.flush
    end
  end

  class Database
    include Reactor

    def moved_player(change)
      Player.update(change.player.id, location_id: change.player.location.id)
    end

    def move_error(change)
    end
  end

  class WebHandler < Struct.new(:controller)
    include Reactor

    def move_error(change)
      controller.flash[:error] = "You cannot move to that location from here"
      controller.redirect_to controller.game_path
    end

    def moved_player(change)
      controller.redirect_to controller.game_path
    end
  end

  def move
    movelog = FileLogger.new("move.log")
    database = Database.new
    web = WebHandler.new(self)
    player = @player.domain_object
    location = Location.find_by_id(params[:destination_location_id]).domain_object

    change = PlayerMover.new.move(player, location)
    database.process(change)
    movelog.process(change)
    web.process(change)
  end

  private

  def find_player
    @player = Player.find_by_id(session[:player_id])
    redirect_to root_path unless @player
  end
end
