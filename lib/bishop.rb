# frozen_string_literal: true

require_relative 'pieces_helpers'

# class for the bishop piece. Holds position, movement, color
class Bishop
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
      [(0..7).to_a, (0..7).to_a],
      [(-7..0).to_a, (-7..0).to_a],
      [(-7..0).to_a, (0..7).to_a.reverse],
      [(0..7).to_a.reverse, (-7..0).to_a]
    ]
  end

  def check_move(goal, board)
    is_valid = false
    @moves.each do |move|
      i = 0
      while i < 8
        new_move = [move[0][i], move[1][i]]
        result = make_move(new_move, position)
        return is_valid = true if result == goal && board[result[0]][result[1]] == ' '
        return is_valid = true if result == goal && board[result[0]][result[1]].color != color

        i += 1
      end
    end
    is_valid
  end
end
