# frozen_string_literal: true

require_relative 'helpers/pieces_helpers'

# class for the king piece. Holds position, movement, color
class King
  include Helpers
  attr_reader :moves, :color
  attr_accessor :position, :moves_made

  def initialize(position, color)
    @position = position
    @color = color
    @moves_made = 0
    movelist
    image
  end

  def to_s
    image
  end

  def image
    case color
    when 'white'
      @image = '♔'
    when 'black'
      @image = '♚'
    end
  end

  def movelist
    @moves = [
      [1, 0],
      [-1, 0],
      [0, -1],
      [0, 1],
      [1, 1],
      [-1, 1],
      [1, -1],
      [-1, -1]
    ]
  end

  def check_move(goal, board, _turns = 1)
    is_valid = false
    moves.each do |move|
      result = make_move(move)
      move_cell = board[result[0]][result[1]] unless result.nil?
      if result == goal && (move_cell == ' ' || move_cell.color != color)
        @moves_made += 1
        return is_valid = true
      end
    end
    is_valid
  end

  def possible_moves(_board)
    all_results = []
    moves.each do |move|
      result = make_move(move)
      all_results << result unless result.nil?
    end
    all_results
  end
end
