class PlayerMover < Struct.new(:web, :websockets, :database)
  def move(player, destination)
    unless (destination)
      web.error("That destination does not exist!")
      return
    end

    if (player.can_move_to?(destination))
      player = player.move_to(destination)
      web.success(player)
      websockets.success(player)
      database.success(player)
    else
      web.error(player)
      websockets.error(player)
      database.error(player)
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
    def initialize(log)
      # could be any other service
      @file = File.open(log, "w+")
    end

    def success(player)
      @file.puts("#{player.name} moved to #{player.location.name}")
      @file.flush
    end

    def error(player)
      @file.puts("ERROR: #{player.name} smacked his head on a wall")
      @file.flush
    end
  end

  class Database
    def success(player)
      player.save!
    end

    def error(player)
    end
  end

  class WebHandler < Struct.new(:controller)
    def error(player)
      controller.flash[:error] = "You cannot move to that location from here"
      controller.redirect_to controller.game_path
    end

    def success(player)
      controller.instance_variable_set(:@player, player)
      controller.redirect_to controller.game_path
    end
  end

  def move
    movelog = FileLogger.new("move.log")
    database = Database.new
    web = WebHandler.new(self)

    PlayerMover.new(web, movelog, database).move(@player, Location.find_by_id(params[:destination_location_id]))
  end

  private

  def find_player
    @player = Player.find_by_id(session[:player_id])
    redirect_to root_path unless @player
  end
end
