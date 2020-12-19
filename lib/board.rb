# frozen_string_literal: true

require_relative 'knight'

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

  def prompt_select_piece
    puts 'Choose the piece by putting the row and column where it is located'
  end

  def select_piece
    pos = ask_position
    piece = @board[pos[0]][pos[1]]
    puts "piece #{piece}"
    piece
  end

  def move_piece(piece, goal)
    if piece.check_move(goal, board) == true
      reset_cell(piece.position)
      insert_piece(piece, goal[0], goal[1])
    else
      puts 'Invalid move!'
      return false
    end
  end

  def reset_cell(position)
    @board[position[0]][position[1]] = ' '
  end

  def ask_position
    loop do
      puts 'Choose row from 0 to 7'
      input = gets.chomp
      puts 'Now choose a column from 0 to 7'
      input2 = gets.chomp
      return [input.to_i, input2.to_i] if input.match(/[0-7]/) && input2.match(/[0-7]/)

      puts 'Input error! Choose a row and a column, from 0 to 7'
    end
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
