require_relative 'pieces_helpers.rb'

class Rook
    include Helpers
     attr_reader :move, :color
     attr_accessor :position

    def initialize(position, color) 
     @position = position
     @color = color
     set_movelist
    end

    def set_movelist
    @moves = [ 
        [ ((0..7).to_a), (Array.new(8, 0)) ],
        [ ((-7..0).to_a), (Array.new(8, 0)) ],
        [ (Array.new(8, 0)), ((0..+7).to_a) ],
        [ (Array.new(8, 0)), ((-7..0).to_a) ]
    ]
    end
    
    def check_move(goal)
        is_valid = false
        @moves.each { |move| 
                i = 0 
               while i < 8
                new_move = [move[0][i], move[1][i]]
                result = make_move(new_move, position)
                return is_valid = true if result == goal
                i += 1
               end
       }  
       is_valid
    end

end