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

  def check_move(goal, board)
    is_valid = false
    moves.each do |move|
      result = make_move(move, position)
      pos_goal = board[result[0]][result[1]] if !result.nil?
      return is_valid = true if result == goal && ( pos_goal == ' ' || pos_goal.color != color)
    end
    is_valid
  end
end
