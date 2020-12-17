# frozen_string_literal: true

# Methods that are generally common between the pieces.
module Helpers
  def check_move(goal)
    @list.each do |move|
      result = make_move(move, position)
      return true if result == goal
    end
  end

  def make_move(move)
    return nil if check_limits(move, position)

    result = []
    result[0] = position[0] + move[0]
    result[1] = position[1] + move[1]
    result
  end

  def check_limits(move, pos)
    (pos[0] + move[0]).negative? || (pos[0] + move[0]) > 7 || (pos[1] + move[1]).negative? || (pos[1] + move[1]) > 7
  end
end
