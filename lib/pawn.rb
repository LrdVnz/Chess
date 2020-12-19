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
    if self.color == 'black' && self.position[0] == 1
       
  end

  def multiple_moves
    is_valid = false
    moves.each do |move|
      result = make_move(move)
      move_cell = board[result[0]][result[1]] unless result.nil?
      # frozen_string_literal: true
      return is_valid = true if result == goal && (move_cell == ' ' || move_cell.color != color)
    end
    is_valid
  end

  def move_forward_check
    result = make_move(move)
    move_cell = board[result[0]][result[1]] unless result.nil?
    # frozen_string_literal: true
    return true if result == goal && (move_cell == ' ' || move_cell.color != color)

    false
  end

end
