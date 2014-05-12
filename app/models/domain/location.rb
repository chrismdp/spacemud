module Domain
  class Location < Struct.new(:id, :name, :exits)
    def can_move_to?(destination)
      exits.include?(destination.id)
    end
  end
end
