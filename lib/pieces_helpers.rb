# frozen_string_literal: true

# Methods that are generally common between the pieces.
module Helpers
  def check_move(goal)
    @list.each do |move|
      result = make_move(move, position)
      return true if result == goal
    end
  end

  def make_move(move)
    return nil if check_limits(move)

    result = []
    result[0] = position[0] + move[0]
    result[1] = position[1] + move[1]
    result
  end

  def check_limits(move)
    result_x = position[0] + move[0]
    result_y = position[1] + move[1]
    result_x.negative? || result_x > 7 || result_y.negative? || result_y > 7
  end

  def check_path_rook(row, column, board)
    @clear = true
    check_vertical(row, column, board)
    check_horizontal(row, column, board)
    @clear
  end

  def check_vertical(row, column, board)
    if row > position[0] && column == position[1]
      check_vert_min(row, column, board)
    elsif row < position[0] && column == position[1]
      check_vert_max(row, column, board)
    end
  end

  def check_horizontal(row, column, board)
    if column > position[1] && row == position[0]
      check_horiz_min(row, column, board)
    elsif column < position[1] && row == position[0]
      check_horiz_max(row, column, board)
    end
  end

  def check_cell(current_cell)
    return false if current_cell != ' ' && current_cell != self

    true
  end

  def check_vert_min(row, column, board)
    row.downto(position[0]) do |n|
      return @clear = false if check_cell(board[n][column]) == false
    end
  end

  def check_vert_max(row, column, board)
    row.upto(position[0]) do |n|
      return @clear = false if check_cell(board[n][column]) == false
    end
  end

  def check_horiz_min(row, column, board)
    column.downto(position[0]) do |n|
      return @clear = false if check_cell(board[row][n]) == false
    end
  end

  def check_horiz_max(row, column, board)
    column.upto(position[0]) do |n|
      return @clear = false if check_cell(board[row][n]) == false
    end
  end

  def check_path_bishop(i, j, board)
    clear = true
    if i > position[0] && j > position[1]
      i.downto(position[0]) do |n|
        j.downto(position[1]) do |m|
          return clear = false if board[n][m] != ' '
        end
      end
    elsif i < position[0] && j < position[1]
      i.upto(position[0]) do |n|
        j.upto(position[1]) do |m|
          return clear = false if board[n][m] != ' '
        end
      end
    end
    if i > position[0] && j < position[1]
      i.downto(position[0]) do |n|
        j.upto(position[1]) do |m|
          return clear = false if board[n][m] != ' '
        end
      end
    elsif i < position[0] && j > position[1]
      i.upto(position[0]) do |n|
        j.downto(position[1]) do |m|
          return clear = false if board[n][m] != ' '
        end
      end
    end
    clear
  end
end
