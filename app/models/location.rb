class Location < ActiveRecord::Base
  has_many :exits

  def domain_object
    Domain::Location.new(id, name, exits.map(&:destination_location_id))
  end
end
