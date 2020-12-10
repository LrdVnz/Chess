require_relative 'knight.rb'

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

 def set_piece(piece, row, column, color) 
   piece = piece.new(row, column, color) 
   put_piece(piece, row, column) 
 end
 
 def put_piece(piece, row, column) 
    @board[row][column] = piece
 end

 def showboard
  board.each { |row| puts "#{row} \n" }
 end

end

board = Board.new