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
        pos_goal = board[result[0]][result[1]] if !result.nil?
        if result == goal && ( pos_goal == ' ' || pos_goal.color != color)
          a = check_path(result,board,new_move)
          return false if a == false
          return is_valid = true 
        end

        i += 1
      end
    end
    is_valid
  end

  def check_path(result, board, move)
      puts "move #{move}"
      i = move[0]
      j = move[1]
      clear = true
      if i > position[0]
        i.downto(position[0]) { |n| return clear = false if board[n][j] != ' ' }
      elsif i < position[0]
        i.upto(position[0]) { |n| return clear = false if board[n][j] != ' ' }
     end
      if j > position[0]
        j.downto(position[0]) { |n| return clear = false if board[i][n] != ' ' }
       elsif j < position[0]
        j.upto(position[0]) { |n| return clear = false if board[i][n] != ' ' }
       end
     clear
  end
end
