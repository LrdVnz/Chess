# frozen_string_literal: true

require_relative 'pieces_helpers'

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
    case self.color 
    when 'white'
      @moves = { 
       'standard'   => [+1,  0], 
       'first_move' => [+2,  0],
       'eat_right'  => [-1, +1], 
       'eat_left'   => [-1, -1]
       }
    when 'black'
      @moves = { 
        'standard'   => [+1,  0], 
        'first_move' => [+2,  0],
        'eat_right'  => [+1, +1],
        'eat_left'   => [+1, -1]
      }
    end
  end

  def image
    case color
    when 'white'
      @image = '♙'
    when 'black'
      @image = '♟︎'
    end
  end

  def to_s
    image
  end

  def check_move(goal, board)
    if self.position[0] == 1 || self.position[0] == 6
      multiple_moves(goal, board)
    else  
      move_forward_check(goal, board)
    end
  end

  def multiple_moves(goal, board)
    is_valid = false
    moves.values.each do |move|
      result = make_move(move)
      move_cell = board[result[0]][result[1]] unless result.nil?
      return is_valid = true if result == goal && (move_cell == ' ' || move_cell.color != color)
    end
    is_valid
  end

  def move_forward_check(goal, board)
    is_valid = false
    default_moves = @moves
    @moves.delete('first_move')
    moves.each do |key, move|
      result = make_move(move)
      move_cell = board[result[0]][result[1]] unless result.nil?
      if result == goal && (key == 'eat_right' || key == 'eat_left')
         if move_cell != ' ' && move_cell.color != self.color
           return is_valid = true     
         end
      end
      return is_valid = true if result == goal && key == 'standard' && move_cell == ' '
    end
    @moves = default_moves
    is_valid
  end 

end
