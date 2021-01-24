# frozen_string_literal: true

# helper for bishop and queen, checking path
module BishopChecker
  def check_path_bishop(result, board)
    @clear = true
    @row = result[0]
    @column = result[1]
    @board = board
    check_bishop_right
    check_bishop_left
    @clear
  end

  def check_bishop_right
    if @row > position[0] && @column > position[1]
      check_bishop_vert_min
    elsif @row < position[0] && @column < position[1]
      check_bishop_vert_max
    end
  end

  def check_bishop_left
    if @row > position[0] && @column < position[1]
      check_bishop_horiz_min
    elsif @row < position[0] && @column > position[1]
      check_bishop_horiz_max
    end
  end

  def check_bishop_vert_min
    move_count = 0 
    while @row > position[0]
      while @column > position[1]
        return @clear = false if move_count != 0 && check_cell == false

        @column -= 1
      end
      move_count += 1 
      @row -= 1
    end
  end

  def check_bishop_vert_max
    move_count = 0 
    while @row < position[0]
      while @column < position[1]
        return @clear = false if move_count != 0 && check_cell == false

        @column += 1
      end
      move_count += 1
      @row += 1
    end
  end

  def check_bishop_horiz_min
    move_count = 0 
    while @row > position[0]
      while @column < position[1]
        return @clear = false if move_count != 0 && check_cell == false

        @column += 1
      end
      move_count += 1
      @row -= 1
    end
  end

  def check_bishop_horiz_max
    move_count = 0 
    while @row < position[0]
      while @column > position[1]
        return @clear = false if move_count != 0 && check_cell == false

        @column -= 1
      end
      move_count += 1
      @row += 1
    end
  end

  def check_cell
    current_cell = @board[@row][@column]
    return false if current_cell != ' ' &&
                    current_cell != self

    true
  end
end
