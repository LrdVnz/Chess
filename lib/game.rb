# frozen_string_literal: true

require_relative 'board'
require_relative 'player'
require_relative 'game_save_module'

# main game script
class Game < Board
  include SaveGame
  attr_accessor :winner, :won, :enemy, :turns, :current_player
  attr_reader :board, :p1, :p2, :saves_path

  def initialize
    @winner = nil
    @enemy = nil
    @won = false 
    @turns = 1
    @board = super
    @current_player = nil
    @saves_path = '/home/vincenzo/Development/the-odin-project-main/Ruby/chess/saves/'
  end

  def start_game
    ask_load
    while @current_player.nil?
      input = ask_input
      case input.downcase
      when 'black'
        start_black
      when 'white'
        start_white
      end
    end
    turn_loop
  end

  def turn_loop
    while won == false
      showboard
      verify_checkmate
      puts "current player is #{@current_player.color}" unless current_player.nil?
      move = do_move
      if move != false
        @turns += 1
        @current_player = @current_player == @p1 ? @p2 : @p1
      end
      @won = win?
    end
  end

  def do_move
    @current_player.text_select_piece
    piece = @current_player.select_piece(board)
    puts 'Choose the goal cell'
    goal = @current_player.ask_position
    move_piece(piece, goal, board, turns)
  end

  def verify_checkmate
    return @winner = @enemy if verify_king_check == true ||
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
    return false if is_checkmate?(piece) == true

    puts 'Choose the goal cell'
    goal = @current_player.ask_position
    move_piece(piece, goal, board, turns)
  end

  def is_checkmate?(king)
    king_moves = king.possible_moves(board)
    return true if (king_moves & @all_enemy_moves.flatten(1)).length == king_moves.length
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

  private

  def ask_input
    puts 'Choose your color. Black or White.'
    gets.chomp
  end

  def start_black
    @p1 = Player.new('black')
    @p2 = Player.new('white')
    @current_player = @p1
  end

  def start_white
    @p1 = Player.new('white')
    @p2 = Player.new('black')
    @current_player = @p1
  end

  def win? 
    @winner == nil ? false : true
  end
end

# Game.new.start_game
