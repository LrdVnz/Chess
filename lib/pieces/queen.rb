# frozen_string_literal: true

require_relative 'helpers/pieces_helpers'
require_relative 'helpers/bishop_checker'
require_relative 'helpers/rook_checker'

# class for the queen piece. Holds position, movement, color
class Queen
  include Helpers
  include RookChecker
  include BishopChecker
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
    @moves = [moves_up, moves_down, moves_right, moves_left,
              moves_diag_up_right, moves_diag_down_left, moves_diag_down_right, moves_diag_up_left]
  end

  def moves_up
    [(0..7).to_a, Array.new(8, 0)]
  end

  def moves_down
    [(-7..0).to_a, Array.new(8, 0)]
  end

  def moves_right
    [Array.new(8, 0), (0..+7).to_a]
  end

  def moves_left
    [Array.new(8, 0), (-7..0).to_a]
  end

  def moves_diag_up_right
    [(0..7).to_a, (0..7).to_a]
  end

  def moves_diag_down_left
    [(-7..0).to_a, (-7..0).to_a]
  end

  def moves_diag_down_right
    [(-7..0).to_a, (0..7).to_a.reverse]
  end

  def moves_diag_up_left
    [(0..7).to_a.reverse, (-7..0).to_a]
  end

  def check_move(goal, board, _turns = 1)
    @goal = goal
    @board = board
    @is_valid = false
    @moves.each do |move|
      0.upto(7) do |num|
        control_move(move, num)
      end
    end
    @is_valid
  end

  def control_move(move, num)
    new_move = [move[0][num], move[1][num]]
    result = make_move(new_move)
    return if result.nil?

    move_cell = @board[result[0]][result[1]]
    @is_valid = check_path(result, @board) if verify_condition(result, @goal, move_cell)
  end

  def verify_condition(result, goal, move_cell)
    if move_cell == ' '
      result == goal
    else
      result == goal && move_cell.color != color
    end
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
    move_cell = board[result[0]][result[1]]
    is_valid = check_path(result, board) if verify_condition(result, result, move_cell)
    @all_results << result unless is_valid == false
  end

  def check_path(result, board)
    is_clear = true
    rook_checked = check_path_rook(result, board)
    bishop_checked = check_path_bishop(result, board)
    return is_clear = rook_checked if rook_checked == false
    return is_clear = bishop_checked if bishop_checked == false

    is_clear
  end
end
