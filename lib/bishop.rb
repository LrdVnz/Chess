# frozen_string_literal: true

require_relative 'pieces_helpers'

# class for the bishop piece. Holds position, movement, color
class Bishop
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

  def check_move(goal, board)
    is_valid = false
    @moves.each do |move|
      i = 0
      while i < 8
        new_move = [move[0][i], move[1][i]]
        result = make_move(new_move)
        move_cell = board[result[0]][result[1]] if !result.nil?
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

  #write it for bishop . if i > position[0] && j > position[0], if i > position[0] && j < position[0]
  def check_path(result, board)
    i = result[0]
    j = result[1]
    clear = true
    if i > position[0] && j > position[1]
      i.downto(position[0]) { |n| 
        j.downto(position[1]) { |m|         
        if board[n][m] != ' '
          return clear = false 
        end 
      }
    }
    elsif i < position[0] && j < position[1] 
      i.upto(position[0]) { |n| 
        j.upto(position[0]) { |m|         
        if board[n][m] != ' '
          return clear = false 
        end 
      }
    }
  end
    if i > position[0] && j < position[1]
      i.downto(position[0]) { |n| 
        j.upto(position[1]) { |m|         
        if board[n][m] != ' '
          return clear = false 
        end 
      }
    }
    elsif i < position[0] && j > position[1]
      i.upto(position[0]) { |n| 
        j.downto(position[1]) { |m|         
        if board[n][m] != ' '
          return clear = false 
        end 
      }
    }
    end
    clear
  end

end
