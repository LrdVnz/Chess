# frozen_string_literal: true

require_relative 'pieces_helpers'

# class for the rook piece. Holds position, movement, color
class Rook
  include Helpers
  attr_reader :move, :color
  attr_accessor :position

  def initialize(position, color)
    @position = position
    @color = color
    set_movelist
  end

  def set_movelist
    @moves = [
      [(0..7).to_a, Array.new(8, 0)],
      [(-7..0).to_a, Array.new(8, 0)],
      [Array.new(8, 0), (0..+7).to_a],
      [Array.new(8, 0), (-7..0).to_a]
    ]
  end

  def check_move(goal, board)
    is_valid = false
    @moves.each do |move|
      i = 0
      while i < 8
        new_move = [move[0][i], move[1][i]]
        result = make_move(new_move, position)
        return is_valid = false if !result.nil? && check_path(result, board)
        return is_valid = true if result == goal && board[result[0]][result[1]] == ' '
        return is_valid = true if result == goal && board[result[0]][result[1]].color != self.color

        i += 1
      end
    end
    is_valid
  end

  def check_path(result, board)
    pos_x = position[0]
    result_x = result[0]
    pos_y = position[1]
    result_y = position[1]
    
    path = ( ( (position[0])..(result[0]) ).to_a, ( (position[1])..(result[1]) ).to_a )
    
    path[0].each { |row|
      path[1].each { |column|
           return false if board[path[row]][path[column]] != ' '  
      }
    }
  end
end
