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
    return nil if check_limits(move)

    result = []
    result[0] = position[0] + move[0]
    result[1] = position[1] + move[1]
    result
  end

  def check_limits(move)
    result_x = position[0] + move[0]
    result_y = position[1] + move[1]
    result_x.negative? || result_x > 7 || result_y.negative? || result_y > 7
  end

  def verify_condition(result, goal, move_cell)
    result == goal && (move_cell == ' ' || move_cell.color != color)
  end
end