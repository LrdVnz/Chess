# frozen_string_literal: true

require_relative 'helpers/pieces_helpers'

# class for the pawn piece. Holds position, movement, color
class Pawn
  include Helpers
  attr_reader :color
  attr_accessor :position, :moves

  def initialize(position, color)
    @position = position
    @color = color
    movelist
    image
  end

  def movelist
    case color
    when 'white'
      @moves = moves_white
    when 'black'
      @moves = moves_black
    end
  end

  def to_s
    image
  end

  def check_move(goal, board)
    if position[0] == 1 || position[0] == 6
      multiple_moves(goal, board)
    else
      move_forward_check(goal, board)
    end
  end

  private

  def multiple_moves(goal, board)
    is_valid = false
    moves.each_value do |move|
      result = make_move(move)
      next if result.nil?

      move_cell = board[result[0]][result[1]]
      return is_valid = true if result == goal && (move_cell == ' ' || move_cell.color != color)
    end
    is_valid
  end

  def move_forward_check(goal, board)
    is_valid = false
    less_moves = @moves.reject { |k, _v| k == 'first_move' }
    less_moves.each do |key, move|
      result = make_move(move)
      move_cell = board[result[0]][result[1]] unless result.nil?
      return is_valid = true if verify_diagonal(result, goal, key, move_cell)
      return is_valid = true if verify_standard(result, goal, key, move_cell)
    end
    is_valid
  end

  def verify_diagonal(result, goal, key, move_cell)
    result == goal && %w[eat_right eat_left].include?(key) &&
      move_cell != ' ' && move_cell.color != color
  end

  def verify_standard(result, goal, key, move_cell)
    result == goal && key == 'standard' && move_cell == ' '
  end

  def image
    case color
    when 'white'
      @image = '♙'
    when 'black'
      @image = '♟︎'
    end
  end

  def moves_white
    {
      'standard' => [+1, 0],
      'first_move' => [+2, 0],
      'eat_right' => [-1, +1],
      'eat_left' => [-1, -1]
    }
  end

  def moves_black
    {
      'standard' => [+1, 0],
      'first_move' => [+2, 0],
      'eat_right' => [+1, +1],
      'eat_left' => [+1, -1]
    }
  end
end
