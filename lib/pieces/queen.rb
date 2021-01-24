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
    @moves = [
      [(0..7).to_a, Array.new(8, 0)],
      [(-7..0).to_a, Array.new(8, 0)],
      [Array.new(8, 0), (0..+7).to_a],
      [Array.new(8, 0), (-7..0).to_a],
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
        next if result.nil? 
        move_cell = board[result[0]][result[1]]
        return is_valid = check_path(result, board) if verify_condition(result, goal, move_cell)
      end
    end
    is_valid
  end

  def verify_condition(result, goal, move_cell)
    print "result #{result} \n"
    print "golaa #{goal} \n"
    print "idiagonallllllll #{result == goal}"
    p "damovec3ll#{move_cell}"
    print "#{move_cell == ' '} \n"
    print '---------'
    if move_cell == ' '
      result == goal
    else
      result == goal && move_cell.color != color
    end
  end

  def check_path(result, board)
    is_clear = true
    i = result[0]
    j = result[1]
    rook_checked = check_path_rook(i, j, board)
    bishop_checked = check_path_bishop(i, j, board)
    return is_clear = rook_checked if rook_checked == false
    return is_clear = bishop_checked if bishop_checked == false
    is_clear
  end
end
