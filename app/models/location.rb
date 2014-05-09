class Location < ActiveRecord::Base
  has_many :exits

  def can_move_to?(destination)
    exits.map(&:destination).include?(destination)
  end
end
