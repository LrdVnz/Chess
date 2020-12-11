# frozen_string_literal: true

require_relative 'board'
require_relative 'pieces_helpers'

# class for the knight piece. Holds position, movement, color
class Knight
  include Helpers
  attr_reader :color, :position

  def initialize(position, color)
    @position = position
    @color = color
    set_movelist
  end
  # search if its possible to have put_on_board in the knight class <--- overcomplicated and unnecessary ?

  def set_movelist
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

  def check_move(goal)
    is_valid = false
    @movelist.each do |move|
      result = make_move(move, position)
      return is_valid = true if result == goal
    end
    is_valid
  end
end
