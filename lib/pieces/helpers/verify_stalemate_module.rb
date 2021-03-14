# frozen_string_literal: true

module VerifyStalemate
  def verify_stalemate
    pick_pieces
    @curr_pieces = remove_king
    possible_moves = curr_possible_moves

    return if !possible_moves.length.zero?

    return if !verify_king_stalemate == false 

    puts "STALEMATE! IT'S A DRAW!"
    @won = true 
  end

  def pick_pieces
    @curr_pieces = []
    board.each  do |row|
      row.each  do |cell|
        next if cell == ' '

        curr_pieces << cell if cell.color == @current_player.color
      end
    end
  end

  def remove_king
   @curr_king = @curr_pieces.select { |piece| piece.instance_of?(King) }
   @curr_pieces.delete_if { |piece| piece.instance_of?(King) }
  end

  def curr_possible_moves
    moves = []
    @curr_pieces.each do |piece|
      moves << piece.possible_moves(board)
    end
    moves
  end

  def verify_king_stalemate
   initial_pos = @curr_king.position
   king_poss_moves = @curr_king.possible_moves(board)
   moves_legal = false 
   king_poss_moves.each { |move|
    move_piece(@curr_king, move, board)
    return moves_legal = true if verify_king_check == true 
    
    board[initial_pos[0]][initial_pos[1]] = @curr_king 
    @curr_king.position = initial_pos
  }   
    board[initial_pos[0]][initial_pos[1]] = @curr_king 
    @curr_king.position = initial_pos
    moves_legal  
  end
end
