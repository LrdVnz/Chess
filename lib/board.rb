
class Board
    attr_accessor :board 

 def initialize
  @board = create_board

 end

 def create_board
  b = []
  8.times { b << Array.new(8, '  ') }
  b
 end

end