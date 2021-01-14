# frozen_string_literal: true

require_relative 'helpers/pieces_helpers'

# class for the knight piece. Holds position, movement, color
class Knight
  include Helpers
  attr_reader :color
  attr_accessor :position

  def initialize(position, color)
    @position = position
    @color = color
    movelist
    image
  end

  def image
    case @color
    when 'white'
      @image = '♘'
    when 'black'
      @image = '♞'
    end
  end

  def to_s
    image
  end

  def movelist
    @movelist = [
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

  def check_move(goal, board, turns = 1)
    is_valid = false
    @movelist.each do |move|
      result = make_move(move)
      move_cell = board[result[0]][result[1]] unless result.nil?
      next unless result == goal
      return is_valid = true if move_cell == ' ' || move_cell.color != color
    end
    is_valid
  end
end
