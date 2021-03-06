# frozen_string_literal: true

project_root = File.dirname(File.absolute_path(__FILE__))
Dir.glob("#{project_root}/pieces/*.rb").sort.each { |file| require file }
require_relative 'pieces/helpers/verify_checkmate_module'
require_relative 'pieces/helpers/board_init_helper'

# Board class. Holds graphical represantion, functions to handle pieces
class Board
  include VerifyCheckmate
  include BoardInit
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
    if piece.instance_of?(King) && check_castling(piece, goal) == true
      check_castling(piece, goal)
    else
      move_checked = piece.check_move(goal, passed_board, turns)
      if move_checked == true
        check_all_moves(piece, goal)
      elsif move_checked == false
        puts 'Invalid move!'
        false
      elsif move_checked['name'] == 'en_passant'
        checked_en_passant(piece, move_checked, goal)
      end
    end
  end

  def check_all_moves(piece, goal)
    check_promote(piece, goal)
    checked_true(piece, goal)
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
    transform_pawn(piece, goal, promote_class)
  end

  private

  def transform_pawn(piece, goal, promote_class)
    new_class = Kernel.const_get(promote_class.capitalize)
    promoted_pawn = new_class.new(goal, piece.color)
    reset_cell(goal)
    insert_piece(promoted_pawn, goal[0], goal[1])
  end

  def checked_true(piece, goal)
    reset_cell(piece.position)
    piece.position = goal
    insert_piece(piece, goal[0], goal[1])
  end

  def checked_en_passant(piece, move_checked, goal)
    reset_cell(piece.position)
    reset_cell(move_checked['enemy_pos'])
    reset_cell(move_checked['enemy_result'])
    piece.position = goal
    insert_piece(piece, goal[0], goal[1])
  end

  def reset_cell(position)
    board[position[0]][position[1]] = ' '
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
