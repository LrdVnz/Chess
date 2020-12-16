# frozen_string_literal: true

require_relative 'pieces_helpers'

# class for the knight piece. Holds position, movement, color
class Knight
  include Helpers
  attr_reader :color, :image, :movelist
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

  def check_move(goal, board)
    is_valid = false
    @movelist.each do |move|
      result = make_move(move, position)
      pos_goal = board[result[0]][result[1]] if !result.nil?
      return is_valid = true if result == goal && ( pos_goal == ' ' || pos_goal.color != color)
    end
    is_valid
  end
end
