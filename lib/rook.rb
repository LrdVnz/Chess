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
    movelist
    image
  end

  def movelist
    @moves = [
      [(0..7).to_a, Array.new(8, 0)],
      [(-7..0).to_a, Array.new(8, 0)],
      [Array.new(8, 0), (0..+7).to_a],
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

  def check_move(goal, board)
    is_valid = false
    @moves.each do |move|
      i = 0
      while i < 8
        new_move = [move[0][i], move[1][i]]
        result = make_move(new_move)
        move_cell = goal_cell(result, board) unless result.nil?
        if result == goal
          if move_cell == ' ' || move_cell.color != color
            a = check_path(result, board)
            return is_valid = false if a == false

            return is_valid = true
          end
        end
        i += 1
      end
    end
    is_valid
  end

  def goal_cell(result, board)
    x = result[0]
    y = result[1]
    board[x][y]
  end

  def check_path(result, board)
    i = result[0]
    j = result[1]
    clear = true
    if i > position[0]
      i.downto(position[0]) { |n| return clear = false if board[n][j] != ' ' }
    elsif i < position[0]
      i.upto(position[0]) { |n| return clear = false if board[n][j] != ' ' }
    end
    if j > position[1]
      j.downto(position[0]) { |n| return clear = false if board[i][n] != ' ' }
    elsif j < position[1]
      j.upto(position[0]) { |n| return clear = false if board[i][n] != ' ' }
    end
    clear
  end
end
