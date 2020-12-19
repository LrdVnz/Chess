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
    return nil if check_limits(move, position)

    result = []
    result[0] = position[0] + move[0]
    result[1] = position[1] + move[1]
    result
  end

  def check_limits(move, pos)
    (pos[0] + move[0]).negative? || (pos[0] + move[0]) > 7 || (pos[1] + move[1]).negative? || (pos[1] + move[1]) > 7
  end

  def check_path_rook(i, j, board)
    clear = true
    if i > position[0] && j == position[1]
      i.downto(position[0]) { |n| return clear = false if board[n][j] != ' ' && board[n][j] != self }
    elsif i < position[0] && j == position[1]
      i.upto(position[0]) { |n| return clear = false if board[n][j] != ' ' && board[n][j] != self }
    end
    if j > position[1] && i == position[0]
      j.downto(position[0]) { |n| return clear = false if board[i][n] != ' ' && board[i][n] != self }
    elsif j < position[1] && i == position[0]
      j.upto(position[0]) { |n| return clear = false if board[i][n] != ' ' && board[i][n] != self }
    end
    clear
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
