require_relative 'board.rb'
require_relative 'pieces_helpers.rb'

class Knight
  include Helpers 
    attr_reader :color , :position

    def initialize(position, color)  
      @color = color
      @position = position
      set_movelist
    end
     #search if its possible to have put_on_board in the knight class <--- overcomplicated and unnecessary ?

     def set_list
     @movelist = [
        [-2, -1],
        [-2, +1],
        [+2, +1],
        [+2, -1],
        [-1, +2],
        [-1, -2],
        [+1, +2],
        [+1, -2]
      ]
    end

    def check_move(goal)
      is_valid = false
      @movelist.each { |move|
           result = make_move(move, position)
            return is_valid = true if result == goal
     }  
     is_valid
    end
      
  
    def make_move(move, pos)
        return nil if check_limits(move, pos)

        result = []
        result[0] = pos[0] + move[0]
        result[1] = pos[1] + move[1]
        result
    end
  
end