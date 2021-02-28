# frozen_string_literal: true

require_relative 'helpers/pieces_helpers'
require_relative 'helpers/rook_checker'

# class for the rook piece. Holds position, movement, color
class Rook
  include RookChecker
  include Helpers
  attr_reader :move, :color
  attr_accessor :position

  def initialize(position, color)
    @position = position
    @color = color
    @moves_made = 0
    movelist
    image
  end

  def movelist
    @moves = [
      [(0..7).to_a, Array.new(8, 0)],
      [(-7..0).to_a, Array.new(8, 0)],
      [Array.new(8, 0), (0..7).to_a],
      [Array.new(8, 0), (-7..0).to_a]
    ]
  end

  def to_s
    image
  end

  def image
    case color
    when 'white'
      @image = '♖'
    when 'black'
      @image = '♜'
    end
  end

  def check_move(goal, board, _turns = 1)
    is_valid = false
    @moves.each do |move|
      0.upto(7) do |i|
        new_move = [move[0][i], move[1][i]]
        result = make_move(new_move)
        move_cell = goal_cell(result, board) unless result.nil?
        if verify_condition(result, goal, move_cell)
          @moves_made += 1
          return is_valid = check_path_rook(result, board)
        end
      end
    end
    is_valid
  end

  def possible_moves(board)
    @all_results = []
    @moves.each do |move|
      0.upto(7) do |i|
        new_move = [move[0][i], move[1][i]]
        result = make_move(new_move)
        next if result.nil?

        check_valid_cell(board, result)
      end
    end
    @all_results
  end

  def check_valid_cell(board, result)
    move_cell = goal_cell(result, board) unless result.nil?
    is_valid = check_path_rook(result, board) if verify_condition(result, result, move_cell)
    @all_results << result unless is_valid == false
  end

  def goal_cell(result, board)
    x = result[0]
    y = result[1]
    board[x][y]
  end
end
