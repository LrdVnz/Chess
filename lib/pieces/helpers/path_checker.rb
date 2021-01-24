# frozen_string_literal: true

# helper for rook, bishop and queen, checking path
module PathChecker
  def check_path_rook(row, column, board)
    puts "position #{position}"
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
    while row > position[0]
      return @clear = false if check_cell(board[n][column]) == false
    row -= 1
    end
  end

  def check_vert_max(row, column, board)
    while row < position[0]
      return @clear = false if check_cell(board[n][column]) == false
    row += 1
    end
  end

  def check_horiz_min(row, column, board)
    while column > position[1]
      return @clear = false if check_cell(board[row][n]) == false
    column -= 1
    end
  end

  def check_horiz_max(row, column, board)
    while column < position[1]
      return @clear = false if check_cell(board[row][n]) == false
    column += 1 
    end
  end

  def check_path_bishop(row, column, board)
    @bishop_clear = true
    check_bishop_right(row, column, board)
    check_bishop_left(row, column, board)
    puts "check bishshsh vert #{check_bishop_right(row, column, board)}"
    puts "check bishop hroziz #{check_bishop_left(row, column, board)}"
    @bishop_clear
  end

  def check_bishop_right(row, column, board)
    if row > position[0] && column > position[1]
      check_bishop_vert_min(row, column, board)
    elsif row < position[0] && column < position[1]
      check_bishop_vert_max(row, column, board)
    end
  end

  def check_bishop_left(row, column, board)
    if row > position[0] && column < position[1]
      check_bishop_horiz_min(row, column, board)
    elsif row < position[0] && column > position[1]
      check_bishop_horiz_max(row, column, board)
    end
  end

  def check_bishop_vert_min(row, column, board)
    while row > position[0]
      while column > position[1]
        return @bishop_clear = false if check_cell(board[n][m]) == false
      end
    end
  end

  def check_bishop_vert_max(row, column, board)
    while row < position[0]
      while column < position[1]
        return @bishop_clear = false if check_cell(board[n][m]) == false
      column += 1
      end
      row += 1
    end
  end

  def check_bishop_horiz_min(row, column, board)
    while row > position[0]
      while column < position[1]
        return @bishop_clear = false if check_cell(board[row][column]) == false
        column += 1 
      end
    row -= 1
    end
  end

  def check_bishop_horiz_max(row, column, board)
    while row < position[0]
      while column > position[1]
        return @bishop_clear = false if check_cell(board[n][m]) == false
      column -= 1
      end
      row += 1 
    end
  end

  def check_cell(current_cell)
    puts "current cell #{current_cell}"
    return false if current_cell != ' ' && current_cell != self

    true
  end
end
