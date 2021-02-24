# frozen_string_literal: true

require_relative 'helpers/pieces_helpers'

# class for the pawn piece. Holds position, movement, color
class Pawn
  include Helpers
  attr_reader :color, :save_move_path
  attr_accessor :position, :moves

  def initialize(position, color)
    @position = position
    @color = color
    @save_move_path = '/home/vincenzo/Documenti/Development/Ruby/Chess/saves/pawn_move/'
    movelist
    image
  end

  def movelist
    case color
    when 'white'
      @moves = moves_white
    when 'black'
      @moves = moves_black
    end
  end

  def to_s
    image
  end

  def check_move(goal, board, _turns = 1)
    if load_move(goal) == true
      en_passant(goal, board)
    elsif conditions_check_move
      multiple_moves(goal, board)
    else
      move_forward_check(goal, board)
    end
  end

  def possible_moves(_board)
    all_results = []
    moves.each_value do |move|
      result = make_move(move)
      all_results << result unless result.nil?
    end
    all_results
  end

  def multiple_moves(goal, board)
    is_valid = false
    moves.each_value do |move|
      result = make_move(move)
      next if result.nil?

      move_cell = board[result[0]][result[1]]
      if check_diagonal(result, goal, move_cell) != false
        save_move(move)
        return is_valid = true
      end
    end
    is_valid
  end

  def move_forward_check(goal, board)
    is_valid = false
    less_moves = @moves.reject { |k, _v| k == 'double_step' }
    less_moves.each do |key, move|
      result = make_move(move)
      move_cell = board[result[0]][result[1]] unless result.nil?
      return is_valid = true if verify_diagonal(result, goal, key, move_cell)
      return is_valid = true if verify_standard(result, goal, key, move_cell)
    end
    is_valid
  end

  def en_passant(goal, board)
    load_move(goal)
    is_valid = false
    less_moves = @moves.reject { |k, _v| %w[double_step standard].include?(k) }
    less_moves.each do |_key, move|
      result = make_move(move)
      move_cell = board[result[0]][result[1]] unless result.nil?
      if check_diagonal(result, goal, move_cell)
        is_valid = { 'name' => 'en_passant', 'enemy_pos' => @previous_move['position'] }
      end
    end
    is_valid
  end

  def save_move(move)
    json = { 'move' => move, 'piece' => itself,
             'position' => @position, 'color' => color }.to_json
    File.open("#{@save_move_path}last_pawn_move", 'w') { |f| f << json }
  end

  def load_move(goal)
    move_save = File.read("#{@save_move_path}last_pawn_move")
    data = JSON.parse(move_save)
    @previous_move = { 'move' => data['move'], 'piece' => data['piece'],
                       'position' => data['position'], 'color' => data['color'] }
    verify_en_passant(@previous_move, goal)
  end

  private

  def verify_en_passant(previous_move, goal)
    return true if previous_move['move'] == 'double_step' && previous_move['color'] != color &&
                   (previous_move['position'][1] == position[1] + 1 || previous_move['position'][1] == position[1] - 1) &&
                   (goal == make_move(@moves['eat_right']) || goal == make_move(@moves['eat_left']))

    false
  end

  def conditions_check_move
    position[0] == 1 && color == 'black' || position[0] == 6 && color == 'white'
  end

  def check_diagonal(result, goal, move_cell)
    if move_cell == ' '
      result == goal
    else
      move_cell.color != color && result == goal
    end
  end

  def verify_diagonal(result, goal, key, move_cell)
    result == goal && key.match(/eat_right|eat_left/) &&
      move_cell != ' ' && move_cell.color != color
  end

  def verify_standard(result, goal, key, move_cell)
    result == goal && key == 'standard' && move_cell == ' '
  end

  def image
    case color
    when 'white'
      @image = '♙'
    when 'black'
      @image = "\u265F"
    end
  end

  def moves_white
    {
      'standard' => [-1, 0],
      'double_step' => [-2, 0],
      'eat_right' => [-1, +1],
      'eat_left' => [-1, -1]
    }
  end

  def moves_black
    {
      'standard' => [+1, 0],
      'double_step' => [+2, 0],
      'eat_right' => [+1, +1],
      'eat_left' => [+1, -1]
    }
  end
end
