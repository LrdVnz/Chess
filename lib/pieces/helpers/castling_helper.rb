# frozen_string_literal: true

# helper to store castling code
module CastlingHelper
  def check_castling(piece, goal)
    @piece = piece
    @goal = goal
    @rook = nil
    return unless @piece.instance_of?(King) && @piece.moves_made.zero?

    if @goal[1] == (@piece.position[1] + 2)
      @rook_move = -1
      castling_right
    elsif @goal[1] == (@piece.position[1] - 2)
      @rook_move = 1
      castling_left
    end
  end

  def castling_right
    utils = create_utils(@piece.position[1] + 1, @piece.position[1] + 2)
    return unless castling_check_conditions(utils)

    @rook = board[@goal[0]][7]
    do_castling if @rook.moves_made.zero?
  end

  def castling_left
    utils = create_utils(@piece.position[1] - 2, @piece.position[1] - 1)
    return unless castling_check_conditions(utils)

    @rook = board[@goal[0]][0]
    do_castling if @rook.moves_made.zero?
  end

  def create_utils(first_column, second_column)
    { 'first_column' => first_column,
      'second_column' => second_column,
      'first_cell' => board[@goal[0]][first_column],
      'second_cell' => board[@goal[0]][second_column] }
  end

  def castling_check_conditions(utils)
    utils['first_cell'] == ' ' &&
      utils['second_cell'] == ' ' &&
      (castling_check_mate(@goal[0], utils['first_column'], utils['second_column']) == true)
  end

  def do_castling
    board[@piece.position[0]][@piece.position[1]] = ' '
    board[@goal[0]][@goal[1]] = @piece
    board[@goal[0]][@goal[1] + @rook_move] = @rook
  end

  def castling_check_mate(row, first_column, second_column)
    return false if verify_first_cell(row, first_column) == false
    return false if verify_second_cell(row, second_column, first_column) == false

    true
  end

  def verify_first_cell(row, first_column)
    board[row][first_column] = @piece
    board[@piece.position[0]][@piece.position[1]] = ' '
    return false if verify_king_check == true
  end

  def verify_second_cell(row, second_column, first_column)
    board[row][second_column] = @piece
    board[row][first_column] = ' '
    return false if verify_king_check == true
  end
end
