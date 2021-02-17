# frozen_string_literal: true

#helper module to store the function for verifying check and checkmate
module VerifyCheckmate
  def verify_checkmate
    return @winner = @enemy if verify_king_check == true &&
                               escape_check == false
  end

  def escape_check
    puts 'You are in check! Move your king.'
    piece = nil
    board.each  do |row|
      row.each  do |cell|
        next if cell == ' '

        piece = cell if cell.instance_of?(King) && 
                        cell.color == @current_player.color
      end
    end
    return false if checkmate?(piece) == true

    move_king(piece)
  end

  def move_king(piece)
    puts 'Choose the goal cell'
    goal = @current_player.ask_position
    move_piece(piece, goal, board, turns)
  end

  def checkmate?(king)
    king_moves = king.possible_moves(board)
    return true if (king_moves & @all_enemy_moves.flatten(1)).length == king_moves.length

    false
  end

  def verify_king_check
    @enemy_pieces = all_enemy_pieces
    @all_enemy_moves = all_possible_moves
    all_moves_cells
  end

  def all_moves_cells
    is_check = false
    @all_enemy_moves.each do |moves_arr|
      moves_arr.each do |move|
        result_cell = board[move[0]][move[1]]
        next if result_cell == ' '
        return is_check = true if result_cell.instance_of?(King) &&
                                  result_cell.color == @current_player.color
      end
    end
    is_check
  end

  def all_possible_moves
    moves = []
    @enemy_pieces.each do |piece|
      moves << piece.possible_moves(board)
    end
    moves
  end

  def all_enemy_pieces
    @enemy = @current_player == @p1 ? @p2 : @p1
    enemy_pieces = []
    board.each do |row|
      row.each do |piece|
        next if piece == ' '

        enemy_pieces << piece if piece.color == @enemy.color
      end
    end
    enemy_pieces
  end
end
