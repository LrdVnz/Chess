# frozen_string_literal: true

require_relative 'knight'

class Board
  attr_accessor :board

  def initialize
    @board = create_board
  end

  def create_board
    b = []
    8.times { b << Array.new(8, ' ') }
    b
  end

  def set_piece(piece, position, color)
    element = piece.new(position, color)
    put_piece(element, position[0], position[1])
  end

  def put_piece(piece, row, column)
    @board[row][column] = piece
  end

  def make_move
    puts 'Choose the piece by putting the row and column where it is located'
    pos = get_position
    piece = @board[pos[0]][pos[1]]
    puts "piece #{piece}"
    goal = get_position
    move_piece(piece, goal)
  end

  def move_piece(piece, goal)
    loop do
      if piece.check_move(goal, board) == true
        @board[piece.position[0]][piece.position[1]] = ' '
        return put_piece(piece, goal[0], goal[1])
      else
        puts 'Invalid move!'
      end
    end
  end

  def get_position
    loop do
      puts 'Choose row from 0 to 7'
      input = gets.chomp
      puts 'Now choose a column from 0 to 7'
      input2 = gets.chomp
      if input.match(/[0-7]/) && input2.match(/[0-7]/)
        first = input.to_i
        second = input2.to_i
        return [first, second]
      else
        puts 'Input error! Choose a row and a column, from 0 to 7'
      end
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

=begin
b = Board.new
b.set_piece(Knight, [0,2], 'black')
b.showboard
b.make_move
b.showboard
=end