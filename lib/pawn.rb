require_relative 'pieces_helpers.rb'

class Pawn 
    include Helpers
     attr_reader :move, :color
     attr_accessor :position

    def initialize(position, color) 
     @position = position
     @color = color
     set_movelist
    end

    def set_movelist
      @move = [+1, 0]
      @first_move = [+2, 0]
    end

    def check_move(goal)
      #if turn == 1 add first move as option
          result = make_move(move, position)
          return true if result == goal
          return false
    end
      

end