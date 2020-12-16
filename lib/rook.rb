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
        result = make_move(new_move, position)
        if !result.nil? 
          x = result[0]
          y = result[1]
          pos_goal = board[x][y]
        end
        if result == goal
         if pos_goal == ' ' || pos_goal.color != color
          a = check_path(result,board,new_move)
          return is_valid = false if a == false
          return is_valid = true 
         end
        end
        i += 1
      end
    end
    is_valid
  end

  def check_path(result, board, move)
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
