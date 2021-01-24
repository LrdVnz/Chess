# frozen_string_literal: true

# helpers for Rook and Queen, check path
module RookChecker
  def check_path_rook(result, board)
    @row = result[0]
    @column = result[1]
    @board = board
    @clear = true
    check_vertical
    check_horizontal
    @clear
  end

  def check_vertical
    if @row > position[0] && @column == position[1]
      check_vert_min
    elsif @row < position[0] && @column == position[1]
      check_vert_max
    end
  end

  def check_horizontal
    if @column > position[1] && @row == position[0]
      check_horiz_min
    elsif @column < position[1] && @row == position[0]
      check_horiz_max
    end
  end

  def check_vert_min
    move_count = 0
    while @row > position[0]
      return @clear = false if move_count != 0 && check_cell == false

      move_count += 1
      @row -= 1
    end
  end

  def check_vert_max
    move_count = 0
    while @row < position[0]
      return @clear = false if move_count != 0 && check_cell == false

      move_count += 1
      @row += 1
    end
  end

  def check_horiz_min
    move_count = 0
    while @column > position[1]
      return @clear = false if move_count != 0 && check_cell == false

      move_count += 1
      @column -= 1
    end
  end

  def check_horiz_max
    move_count = 0
    while @column < position[1]
      return @clear = false if move_count != 0 && check_cell == false

      move_count += 1
      @column += 1
    end
  end

  def check_cell
    current_cell = @board[@row][@column]
    return false if current_cell != ' ' &&
                    current_cell != self

    true
  end
end
