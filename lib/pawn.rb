# frozen_string_literal: true

require_relative 'pieces_helpers'

# class for the pawn piece. Holds position, movement, color
class Pawn
  include Helpers
  attr_reader :move, :color
  attr_accessor :position

  def initialize(position, color)
    @position = position
    @color = color
    movelist
    image
  end

  def movelist
    @move = [+1, 0]
    @first_move = [+2, 0]
  end

  def image
    case color
    when 'white'
      @image = '♙'
    when 'black'
      @image = '♟︎'
    end
  end

  def to_s
    image
  end

  def check_move(goal, board)
    # if turn == 1 add first move as option
    result = make_move(move)
    move_cell = board[result[0]][result[1]] unless result.nil?
    # frozen_string_literal: true
    # class for the pawn piece. Holds position, movement, color
    # if turn == 1 add first move as option
    return true if result == goal && (move_cell == ' ' || move_cell.color != color)

    false
  end
end
