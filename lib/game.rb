# frozen_string_literal: true

require_relative 'board'

# main game script
class Game < Board
  attr_accessor :winner, :turns, :current_player
  attr_reader :b, :p1, :p2

  def initialize
    @winner = false
    @turns = 0
    @board = super
    @current_player = nil
  end

  def start_game
    loop do
      input = ask_input
      case input.downcase
      when 'black'
        return start_black
      when 'white'
        return start_white
      end
    end
  end

  def turn_loop
    while winner == false
      move = @current_player.do_move(board)
      if move != false
        @turns += 1
        @current_player = @current_player == @p1 ? @p2 : @p1
      end
      return if win? == true
    end
  end

  private

  def ask_input
    puts 'Choose your color. Black or White.'
    gets.chomp
  end

  def start_black
    @p1 = 'black'
    @p2 = 'white'
    @current_player = @p1
  end

  def start_white
    @p1 = 'white'
    @p2 = 'black'
    @current_player = @p1
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
