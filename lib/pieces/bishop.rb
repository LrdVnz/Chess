# frozen_string_literal: true

require_relative 'helpers/pieces_helpers'
require_relative 'helpers/bishop_checker'

# class for the bishop piece. Holds position, movement, color
class Bishop
  include BishopChecker
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

  def check_move(goal, board, _turns = 1)
    is_valid = false
    @moves.each do |move|
      0.upto(7) do |i|
        new_move = [move[0][i], move[1][i]]
        result = make_move(new_move)
        move_cell = board[result[0]][result[1]] unless result.nil?
        return is_valid = check_path_bishop(result, board) if verify_conditions(result, goal, move_cell)
      end
    end
    is_valid
  end

  def possible_moves(board)
    is_valid = false
    all_results = []
    @moves.each do |move|
      0.upto(7) do |i|
        new_move = [move[0][i], move[1][i]]
        result = make_move(new_move)
        next if result.nil?

        move_cell = board[result[0]][result[1]]
        is_valid = check_path_bishop(result, board) if verify_conditions(result, result, move_cell)
        all_results << result unless is_valid == false
      end
    end
    all_results
  end

  def verify_conditions(result, goal, move_cell)
    result == goal && (move_cell == ' ' || move_cell.color != color)
  end
end
