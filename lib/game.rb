# frozen_string_literal: true

require_relative 'board'

# main game script
class Game < Board
  attr_accessor :winner, :turns, :current_player
  attr_reader :b, :p1, :p2

  def initialize
    @winner = false
    @turns = 0
    @board = Board.new.board
    @current_player = nil
  end

  def start_game
    loop do
      puts 'Choose your color. Black or White.'
      input = gets.chomp
      case input.downcase
      when 'black'
        @p1 = 'black'
        @p2 = 'white'
        @current_player = @p1
        break
      when 'white'
        @p1 = 'white'
        @p2 = 'black'
        @current_player = @p1
        break
      end
    end
  end

  def turn_loop
    while winner == false
      @current_player.do_move(board)
      if move != false
        @turns += 1
        @current_player = @current_player == @p1 ? @p2 : @p1
      end
      return if win? == true
    end
  end

  def win?
    @winner
  end
end

# b = Board.new
# b.create_piece(Knight, [0,2], 'black')
# b.showboard
# b.start_move
# b.showboard
