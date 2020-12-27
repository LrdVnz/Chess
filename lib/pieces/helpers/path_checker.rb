# frozen_string_literal: true

# helper for rook, bishop and queen, checking path
module PathChecker
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

  def check_path_bishop(row, column, board)
    @bishop_clear = true
    check_bishop_vert(row, column, board)
    check_bishop_horiz(row, column, board)
    @bishop_clear
  end

  def check_bishop_vert(row, column, board)
    if row > position[0] && column > position[1]
      check_bishop_vert_min(row, column, board)
    elsif row < position[0] && column < position[1]
      check_bishop_vert_max(row, column, board)
    end
  end

  def check_bishop_horiz(row, column, board)
    if row > position[0] && column < position[1]
      check_bishop_horiz_min(row, column, board)
    elsif row < position[0] && column > position[1]
      check_bishop_horiz_max(row, column, board)
    end
  end

  def check_bishop_vert_min(row, column, board)
    row.downto(position[0]) do |n|
      column.downto(position[1]) do |m|
        return @bishop_clear = false if check_cell(board[n][m]) == false
      end
    end
  end

  def check_bishop_vert_max(row, column, board)
    row.upto(position[0]) do |n|
      column.upto(position[1]) do |m|
        return @bishop_clear = false if check_cell(board[n][m]) == false
      end
    end
  end

  def check_bishop_horiz_min(row, column, board)
    row.downto(position[0]) do |n|
      column.upto(position[1]) do |m|
        return @bishop_clear = false if check_cell(board[n][m]) == false
      end
    end
  end

  def check_bishop_horiz_max(row, column, board)
    row.upto(position[0]) do |n|
      column.downto(position[1]) do |m|
        return @bishop_clear = false if check_cell(board[n][m]) == false
      end
    end
  end

  def check_cell(current_cell)
    return false if current_cell != ' ' && current_cell != self

    true
  end
end
