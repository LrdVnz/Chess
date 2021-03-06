
#helper to store castling code 
module CastlingHelper 
  def castling_check_mate(piece, row, first_column, second_column) 
    board[row][first_column] = piece 
    board[piece.position[0]][piece.position[1]] = ' '
    return false if verify_king_check == true 
    board[row][second_column] = piece 
    board[row][first_column] = ' '
    return false if verify_king_check == true 
    board[row][second_column + 1] = piece 
    board[row][second_column] = ' '
    return false if verify_king_check == true 

    board[row][second_column + 1] = ' '
    true 
  end



  def check_castling(piece, goal)
    @rook = nil 
    print piece.class == King
     if piece.class == King && piece.moves_made == 0
       if goal[1] == (piece.position[1] + 2)  
         castling_right(piece,goal)
       elsif goal[1] == (piece.position[1] - 2)
         castling_left(piece,goal)
        end
     end 
  end


  def castling_right(piece, goal)
    row = goal[0]
    first_column = piece.position[1] + 1
    second_column = piece.position[1] + 2
    first_cell = board[row][first_column]
    second_cell = board[row][second_column]
    if first_cell == ' ' && second_cell == ' '
        if castling_check_mate(piece, row,first_column, second_column) == true         
          showboard
          @rook = board[goal[0]][7] 
        if @rook.moves_made.zero? 
         do_castling_right(piece, goal)
        end
        end
      end
  end

  def castling_left(piece,goal)
    row = goal[0]
    first_column = piece.position[1] - 1
    second_column = piece.position[1] - 2
    first_cell = board[row][first_column]
    second_cell = board[row][second_column]
    if first_cell == ' ' && second_cell == ' '
      if castling_check_mate(piece, row,first_column, second_column) == true 
        @rook = board[goal[0]][0]        
        if @rook.moves_made.zero?
          do_castling_left(piece, goal)
        end 
      end
    end
  end 

  def do_castling_right(piece, goal)
      board[piece.position[0]][piece.position[1]] = ' '
      board[goal[0]][goal[1]] = piece
      board[goal[0]][goal[1] - 1] = @rook
  end

  def do_castling_left(piece, goal)
    board[piece.position[0]][piece.position[1]] = ' '
    board[goal[0]][goal[1]] = piece
    board[goal[0]][goal[1]  + 1] = rook
  end
end