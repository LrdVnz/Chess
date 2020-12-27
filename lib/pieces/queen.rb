# frozen_string_literal: true
require_relative 'helpers/pieces_helpers.rb'
require_relative 'helpers/path_checker.rb'

# class for the queen piece. Holds position, movement, color
class Queen
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

  def image
    case color
    when 'white'
      @image = '♕'
    when 'black'
      @image = '♛'
    end
  end

  def to_s
    image
  end

  def movelist
    @moves = [
      [(0..7).to_a, Array.new(8, 0)],
      [(-7..0).to_a, Array.new(8, 0)],
      [Array.new(8, 0), (0..+7).to_a],
      [Array.new(8, 0), (-7..0).to_a],
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
        return is_valid = check_path(result, board) if verify_condition(result, goal, move_cell)
      end
    end
    is_valid
  end

  def verify_condition(result, goal, move_cell)
    result == goal && (move_cell == ' ' || move_cell.color != color)
  end

  def check_path(result, board)
    is_clear = true
    i = result[0]
    j = result[1]
    return is_clear = check_path_rook(i, j, board) if check_path_rook(i, j, board) == false
    return is_clear = check_path_bishop(i, j, board) if check_path_bishop(i, j, board) == false

    is_clear
  end
end
