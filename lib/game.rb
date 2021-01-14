# frozen_string_literal: true

require_relative 'board'
require_relative 'player'
require_relative 'game_save_module'

# main game script
class Game < Board
  include SaveGame
  attr_accessor :winner, :turns, :current_player
  attr_reader :board, :p1, :p2, :saves_path

  def initialize
    @winner = false
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
    while winner == false
      showboard
      puts "current player is #{@current_player.color}" unless current_player.nil?
      move = do_move
      if move != false
        @turns += 1
        @current_player = @current_player == @p1 ? @p2 : @p1
      end
      @winner = win?
    end
  end

  def do_move
    @current_player.text_select_piece
    piece = @current_player.select_piece(board)
    puts "Choose the goal cell"
    goal = @current_player.ask_position
    move_piece(piece, goal, board, turns)
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
    @winner
  end
end

Game.new.start_game
