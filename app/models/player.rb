class Player < ActiveRecord::Base
  belongs_to :location

  def domain_object
    Domain::Player.new(id, name, age, location.domain_object)
  end
end
