# frozen_string_literal: true

require 'pry'
require_relative 'board'
# class for the player. For holding color, controlling movement.
class Player < Board
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def select_piece(board)
    pos = input_piece(board)
    piece = board[pos[0]][pos[1]]
    puts "piece #{piece}"
    piece
  end

  def input_piece(board)
    loop do
      pos = ask_position
      return pos if verify_color(pos, board) == true
    end
  end

  def verify_color(pos, board)
    cell = board[pos[0]][pos[1]]
    if cell != ' ' && cell.color != color
      puts 'Please choose one of your pieces.'
      return false
    elsif cell == ' '
      puts 'Please choose a piece'
      return false
    end
    true
  end

  def text_select_piece
    puts 'Choose the piece by putting the row and column where it is located'
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
end
