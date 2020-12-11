# frozen_string_literal: true

require_relative 'pieces_helpers'

# class for the king piece. Holds position, movement, color
class King
  include Helpers
  attr_reader :moves, :color
  attr_accessor :position

  def initialize(position, color)
    @position = position
    @color = color
    set_movelist
  end

  def set_movelist
    @moves = [
      [1, 0],
      [-1, 0],
      [0, -1],
      [0, 1]
    ]
  end

  def check_move(goal)
    is_valid = false
    moves.each do |move|
      return is_valid = true if make_move(move, position) == goal
    end
    is_valid
  end
end
