require_relative 'pieces_helpers.rb'

class Pawn 
    include Helpers
     attr_reader :movelist, :color
     attr_accessor :position

    def initialize(position, color) 
     @position = position
     @color = color
     set_movelist
    end

    def movelist
      @move = [+1, 0]
      @first_move = [+2, 0]
    end
end