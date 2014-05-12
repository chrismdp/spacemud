module Domain
  class Player < Struct.new(:id, :name, :age, :location)
    def can_move_to?(destination)
      location.can_move_to?(destination)
    end

    def move_to(destination)
      dup.tap { |player| player.location = destination }.freeze
    end
  end
end
