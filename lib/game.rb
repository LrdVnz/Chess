# frozen_string_literal: true

require_relative 'board.rb'

# main game script
class Game < Board 
    attr_accessor :winner, :turns, :current_player
    attr_reader :b
   def initialize
     @winner = false 
     @turns = 0 
     @board = Board.new 
     @current_player = nil 
   end
   
  def turn_loop
    while winner == false
      board.prompt_select_piece
      piece = board.select_piece
      goal = board.ask_position
      move = board.move_piece(piece,goal)
      if move != false
        @turns += 1 
        @current_player = nil #change_player
      end
      return if win? == true 
    end
  end

  def win? 
     @winner 
  end

end

=begin
b = Board.new
b.create_piece(Knight, [0,2], 'black')
b.showboard
b.start_move
b.showboard
=end