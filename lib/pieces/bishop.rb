# frozen_string_literal: true

require_relative 'helpers/pieces_helpers.rb'
require_relative 'helpers/path_checker.rb'

# class for the bishop piece. Holds position, movement, color
class Bishop
  include PathChecker
  include Helpers
  attr_reader :moves, :color
  attr_accessor :position

  def initialize(position, color)
    @position = position
    @color = color
    movelist
    image
  end

  def to_s
    image
  end

  def image
    case color
    when 'white'
      @image = '♗'
    when 'black'
      @image = '♝'
    end
  end

  def movelist
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
      0.upto(7) do |i|
        new_move = [move[0][i], move[1][i]]
        result = make_move(new_move)
        move_cell = board[result[0]][result[1]] unless result.nil?
        return is_valid = path_clear?(result, board) if verify_conditions(result, goal, move_cell)
      end
    end
    is_valid
  end

  def verify_conditions(result, goal, move_cell)
    result == goal && (move_cell == ' ' || move_cell.color != color)
  end

  def path_clear?(result, board)
    path_clear = check_path(result, board)
    case path_clear
    when false
      false
    else
      true
    end
  end

  def check_path(result, board)
    i = result[0]
    j = result[1]
    check_path_bishop(i, j, board)
  end
end
