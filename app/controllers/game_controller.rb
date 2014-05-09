class PlayerMover < Struct.new(:web, :websockets, :database)
  def move(player, destination)
    unless (destination)
      web.error("That destination does not exist!")
      return
    end

    if (player.can_move_to?(destination))
      player = player.move_to(destination)
      web.success(player)
      websockets.success("#{player.name} moved to #{destination.name}")
      database.success(player)
    else
      web.error("You cannot move to that location from here")
      websockets.error("#{player.name} smacked his head on a wall")
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

    def success(msg)
      @file.puts(msg)
      @file.flush
    end

    def error(msg)
      @file.puts "ERROR: #{msg}"
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
    def error(msg)
      controller.flash[:error] = msg
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
