# frozen_string_literal: true

require './lib/game'
Dir['./lib/pieces/*.rb'].sort.each { |file| require file }
# include bishop in second example ----> occupied path
RSpec.shared_examples 'move_piece_shared' do
  before(:each) do
    allow_any_instance_of(Player).to receive(:puts)
    allow_any_instance_of(Board).to receive(:showboard)
    allow_any_instance_of(Game).to receive(:ask_load)
    allow(game_shared).to receive(:ask_input).and_return('black')
    allow(game_shared).to receive(:turn_loop)
    game_shared.start_game
    allow_any_instance_of(Player).to receive(:text_select_piece)
  end

  let(:game_shared) { Game.new }
  let(:board) { game_shared.board }

  context 'when giving a valid goal for the piece' do
    it 'moves piece to the goal and resets initial cell' do
      pos0 = current_class.position[0]
      pos1 = current_class.position[1]
      verify_class = board[pos0][pos1]
      board[valid_goal[0]][valid_goal[1]] = ' '
      allow_any_instance_of(Player).to receive(:input_piece).and_return([pos0, pos1])
      allow_any_instance_of(Player).to receive(:ask_position).and_return([valid_goal[0], valid_goal[1]])
      allow(game_shared).to receive(:puts)
      game_shared.do_move
      expect(board[valid_goal[0]][valid_goal[1]]).to be(verify_class)
      expect(board[pos0][pos1]).to eq(' ')
    end
  end

  context 'when giving an invalid goal' do
    it "puts 'Invalid move!' " do
      pos0 = current_class.position[0]
      pos1 = current_class.position[1]
      allow_any_instance_of(Player).to receive(:input_piece).and_return([pos0, pos1])
      allow_any_instance_of(Player).to receive(:ask_position).and_return([invalid_goal[0], invalid_goal[1]])
      allow(game_shared).to receive(:puts).with('Choose the goal cell')
      allow_any_instance_of(Player).to receive(:print)
      expect(game_shared).to receive(:move_piece).and_return(false)
      game_shared.do_move
    end
  end

  context 'when given a cell occupied by a piece of another color' do
    it 'Moves it to the cell' do
      pawn = Pawn.new([valid_goal[0], valid_goal[1]], 'white')
      pos0 = current_class.position[0]
      pos1 = current_class.position[1]
      board[pos0][pos1] = current_class
      board[valid_goal[0]][valid_goal[1]] = pawn
      allow_any_instance_of(Player).to receive(:input_piece).and_return([pos0, pos1])
      allow_any_instance_of(Player).to receive(:ask_position).and_return([valid_goal[0], valid_goal[1]])
      allow(game_shared).to receive(:puts)
      game_shared.do_move
      expect(board[valid_goal[0]][valid_goal[1]]).to be(current_class)
    end
  end
end

RSpec.shared_examples 'move_piece_occupied_path' do
  let(:board_second_shared) { Board.new }
  let(:pawn) { Pawn.new([2, 2], 'white') }
  let(:board) { board_second_shared.board }

  before(:each) do
    allow_any_instance_of(Board).to receive(:showboard)
  end

  context 'when given a cell that is occupied by same color piece' do
    it 'puts error' do
      x = current_class.position[0]
      y = current_class.position[1]
      board[x][y] = current_class
      board[2][2] = pawn
      expect(board_second_shared).to receive(:puts).with('Invalid move!')
      board_second_shared.move_piece(current_class, invalid_goal, board)
    end
  end

  context 'when given a cell where the path is occupied' do
    it "returns 'Invalid move!' " do
      current_class_x = current_class.position[0]
      current_class_y = current_class.position[1]
      board[current_class_x][current_class_y] = current_class
      board[3][2] = pawn
      expect(board_second_shared).to receive(:puts).with('Invalid move!')
      board_second_shared.move_piece(current_class, invalid_goal, board)
    end
  end
end
