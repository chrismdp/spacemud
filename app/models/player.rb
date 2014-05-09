class Player < ActiveRecord::Base
  belongs_to :location

  def can_move_to?(destination)
    location.can_move_to?(destination)
  end

  def move_to(destination)
    clone.tap { |player| player.location_id = destination.id }
  end
end
