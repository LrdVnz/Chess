require_relative 'board.rb'

class Knight
    attr_reader :color , :position

    def initialize(position, color)  
      @color = color
      @position = position
      set_list
    end
     #search if its possible to have put_on_board in the knight class

     def set_list
     @list = [
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
        puts "reaaachedddd check moveeeeeeeeuuuu"
      @list.each { |move|
           result = make_move(move, position)
            puts "resultoo #{result}"
            return true if result == goal
     }  
    end
      
  
    def make_move(move, pos)
       return nil if check_limits(move, pos)

        result = []
        result[0] = pos[0] + move[0]
        result[1] = pos[1] + move[1]
        result
    end
  
    private 
    
    def check_limits(move, pos)
      (pos[0] + move[0]).negative? || (pos[0] + move[0]) > 7 || (pos[1] + move[1]).negative? || (pos[1] + move[1]) > 7
    end
end