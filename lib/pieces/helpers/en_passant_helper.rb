# frozen_string_literal: true

# en_passant helper
module EnPassant
  def en_passant(goal, board)
    load_move(goal)
    @is_valid = false
    less_moves = @moves.reject { |k, _v| %w[double_step standard].include?(k) }
    verify_less_moves(less_moves, board, goal)
    @is_valid
  end

  def verify_less_moves(less_moves, board, goal)
    less_moves.each do |_key, move|
      result = make_move(move)
      next if result.nil?

      move_cell = board[result[0]][result[1]]
      if check_diagonal(result, goal, move_cell)
        @is_valid = { 'name' => 'en_passant', 'enemy_pos' => @previous_move['position'],
                      'enemy_result' => @previous_move['result'] }
      end
    end
  end

  def save_move(move, result)
    json = { 'move' => move, 'piece' => itself,
             'position' => @prev_pos, 'color' => color,
             'result' => result }.to_json
    File.open("#{@save_move_path}last_pawn_move", 'w') { |f| f << json }
  end

  def load_move(goal)
    move_save = File.read("#{@save_move_path}last_pawn_move")
    data = JSON.parse(move_save)
    @previous_move = { 'move' => data['move'], 'piece' => data['piece'],
                       'position' => data['position'], 'color' => data['color'],
                       'result' => data['result'] }
                       
    verify_en_passant(@previous_move, goal)
  end

  private

  def verify_en_passant(previous_move, goal)
    return true if verify_move(previous_move) &&
                   previous_move['color'] != color &&
                   verify_previous_pos(previous_move) &&
                   verify_goal(goal)

    false
  end

  def verify_move(previous_move)
    previous_move['move'] == [-2, 0] || previous_move['move'] == [+2, 0]
  end

  def verify_previous_pos(previous_move)
    return if previous_move['position'].nil? 
    previous_move['position'][1] == position[1] + 1 || previous_move['position'][1] == position[1] - 1
  end

  def verify_goal(goal)
    goal == make_move(@moves['eat_right']) || goal == make_move(@moves['eat_left'])
  end
end

#
#     print "\n edaverify \n"
#     print verify_move(previous_move)
#     print "\n edaprevcolor \n"
#     print previous_move['color'] != color
#     print "\n eda prevpos \n"
#     print verify_previous_pos(previous_move)
#     print "\n heeefhhhhhhhhhhhhhhhh"
#
#     print "\n PERFAVOREEEEEEEE  moves \n"
#     print @moves
#     print "\n niaaaa GOAL "
#     print goal
#     print "\n ANCORAAAAHAH make MOVE"
#     print make_move(@moves['eat_right'])
#     print "\n dippiiii MAKE MVE LEFTs"
#     print make_move(@moves['eat_left'])
#     print "\n \n \n"
#     print goal == make_move(@moves['eat_right']) || goal == make_move(@moves['eat_left'])
