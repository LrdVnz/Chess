    
module Helpers 

    def check_move(goal)
        @list.each { |move| 
             result = make_move(move, position)
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
        
    def check_limits(move, pos)
        (pos[0] + move[0]).negative? || (pos[0] + move[0]) > 7 || (pos[1] + move[1]).negative? || (pos[1] + move[1]) > 7
    end

    
    
end