# frozen_string_literal: true

require_relative 'knight'

# Board class. Holds graphical represantion, functions to handle pieces
class Board
  attr_accessor :board, :winner

  def initialize
    @board = create_board
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
    @board[row][column] = piece
  end

  def move_piece(piece, goal)
    if piece.check_move(goal, board) == true
      reset_cell(piece.position)
      insert_piece(piece, goal[0], goal[1])
    else
      puts 'Invalid move!'
      false
    end
  end

  def reset_cell(position)
    @board[position[0]][position[1]] = ' '
  end

  def showboard
    board.each do |row|
      row.each do |tile|
        print "[ #{tile} ]"
      end
      puts "\n ---------------------------------------"
    end
  end
end
