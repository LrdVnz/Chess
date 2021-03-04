# frozen_string_literal: true

project_root = File.dirname(File.absolute_path(__FILE__))
Dir.glob("#{project_root}/pieces/*.rb").sort.each { |file| require file }

# Board class. Holds graphical represantion, functions to handle pieces
class Board
  attr_accessor :board, :winner

  def initialize
    @board = create_board
    init_pieces
    @board
  end

  def create_board
    b = []
    8.times { b << Array.new(8, ' ') }
    b
  end

  def create_piece(piece, position, color)
    new_piece = piece.new(position, color)
    insert_piece(new_piece, position[0], position[1])
  end

  def insert_piece(piece, row, column)
    board[row][column] = piece
  end

  def init_pieces
    black_side_first
    black_side_pawns
    white_side_first
    white_side_pawns
  end

  def move_piece(piece, goal, passed_board, turns = 1)
    move_checked = piece.check_move(goal, passed_board, turns)
    if move_checked == true
      check_castling(piece, goal)
      check_promote(piece, goal)
      checked_true(piece, goal)
    elsif move_checked == false
      puts 'Invalid move!'
      false
    elsif move_checked['name'] == 'en_passant'
      checked_en_passant(piece, move_checked, goal)
    end
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

  def check_promote(piece, goal)
    if piece.instance_of?(Pawn) && (piece.color == 'white' && (goal[0]).zero? ||
         piece.color == 'black' && goal[0] == 7)
      promote_pawn(piece, goal)
    end
  end

  def promote_pawn(piece, goal)
    puts 'Choose which class to promote your pawn to.'
    promote_class = nil
    loop do
      promote_class = gets.chomp.downcase
      break if promote_class.match(/(queen|knight|rook|bishop)/)

      print 'Choose a valid class'
    end
    new_class = Kernel.const_get(promote_class.capitalize)
    promoted_pawn = new_class.new(goal, piece.color)
    reset_cell(goal)
    insert_piece(promoted_pawn, goal[0], goal[1])
  end

  private

  def checked_true(piece, goal)
    reset_cell(piece.position)
    piece.position = goal
    insert_piece(piece, goal[0], goal[1])
  end

  def checked_en_passant(piece, move_checked, goal)
    reset_cell(piece.position)
    reset_cell(move_checked['enemy_pos'])
    piece.position = goal
    insert_piece(piece, goal[0], goal[1])
  end

  def reset_cell(position)
    board[position[0]][position[1]] = ' '
  end

  def black_side_first
    board[0] = [
      Rook.new([0, 0], 'black'),
      Knight.new([0, 1], 'black'),
      Bishop.new([0, 2], 'black'),
      Queen.new([0, 3], 'black'),
      King.new([0, 4], 'black'),
      Bishop.new([0, 5], 'black'),
      Knight.new([0, 6], 'black'),
      Rook.new([0, 7], 'black')
    ]
  end

  def black_side_pawns
    board[1].each_index do |index|
      board[1][index] = Pawn.new([1, index], 'black')
    end
  end

  def white_side_first
    board[7] = [
      Rook.new([7, 0], 'white'),
      Knight.new([7, 1], 'white'),
      Bishop.new([7, 2], 'white'),
      Queen.new([7, 3], 'white'),
      King.new([7, 4], 'white'),
      Bishop.new([7, 5], 'white'),
      Knight.new([7, 6], 'white'),
      Rook.new([7, 7], 'white')
    ]
  end

  def white_side_pawns
    board[6].each_index do |index|
      board[6][index] = Pawn.new([6, index], 'white')
    end
  end

  def showboard
    board.each do |row|
      row.each do |tile|
        print "[ #{tile} ]"
      end
      puts "\n ---------------------------------------"
    end
    puts "\n"
  end
end
