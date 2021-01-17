# frozen_string_literal: true
require './lib/game.rb'
Dir['./lib/pieces/*.rb'].sort.each { |file| require file }
# include bishop in second example ----> occupied path
RSpec.shared_examples 'move_piece_shared' do
  before(:each) do
    #allow_any_instance_of(Board).to receive(:showboard)
    allow_any_instance_of(Game).to receive(:ask_load)
  end

  let(:game_shared) { Game.new }
  let(:board) { game_shared.board }

  context 'when giving a valid goal for the piece' do
    before do 
      allow(game_shared).to receive(:ask_input).and_return('black')
      allow(game_shared).to receive(:turn_loop)
      game_shared.start_game
      allow_any_instance_of(Player).to receive(:text_select_piece)
    end

    it 'moves piece to the goal and resets initial cell' do
      verify_class = board[current_class.position[0]][current_class.position[1]]
      game_shared.board[valid_goal[0]][valid_goal[1]] = ' '
      allow_any_instance_of(Player).to receive(:input_piece).and_return([0,3])
      allow_any_instance_of(Player).to receive(:ask_position).and_return([valid_goal[0], valid_goal[1]])
      game_shared.do_move
      expect(board[valid_goal[0]][valid_goal[1]]).to be(verify_class)
      expect(board[current_class.position[0]][current_class.position[1]])
    end
  end

  context 'when giving an invalid goal' do
    xit "puts 'Invalid move!' " do
      expect(board).to receive(:puts).with('Invalid move!')
      board_shared_ex.move_piece(current_class, invalid_goal, board)
    end
  end

  context 'when given a cell occupied by a piece of another color' do

    xit 'Moves it to the cell' do
      pawn = Pawn.new([1, 0], 'black')
      start_x = current_class.position[0]
      start_y = current_class.position[1]
      board[start_x][start_y] = current_class
      board[1][0] = pawn
      board_shared_ex.move_piece(pawn, [start_x, start_y], board)
      expect(board[start_x][start_y]).to be(pawn)
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
