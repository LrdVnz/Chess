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
    if piece.check_move(goal, passed_board, turns) == true
      reset_cell(piece.position)
      piece.position = goal
      insert_piece(piece, goal[0], goal[1])
    else
      puts 'Invalid move!'
      false
    end
  end

  private

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
