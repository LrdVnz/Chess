# frozen_string_literal: true

require './lib/game'
Dir['./lib/pieces/*.rb'].sort.each { |file| require file }
# include bishop in second example ----> occupied path
RSpec.shared_examples 'move_piece_shared' do
  before do
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
    before do
      @pos0 = current_class.position[0]
      @pos1 = current_class.position[1]
      @verify_class = board[@pos0][@pos1]
      allow_any_instance_of(Player).to receive(:input_piece).and_return([@pos0, @pos1])
      allow_any_instance_of(Player).to receive(:ask_position).and_return([valid_goal[0], valid_goal[1]])
      allow(game_shared).to receive(:puts)
    end

    it 'moves piece to the goal and resets initial cell' do
      board[valid_goal[0]][valid_goal[1]] = ' '
      game_shared.do_move
      expect(board[valid_goal[0]][valid_goal[1]]).to be(@verify_class)
      expect(board[@pos0][@pos1]).to eq(' ')
    end
  end

  context 'when giving an invalid goal' do
    before do
      @pos0 = current_class.position[0]
      @pos1 = current_class.position[1]
      allow_any_instance_of(Player).to receive(:input_piece).and_return([@pos0, @pos1])
      allow_any_instance_of(Player).to receive(:ask_position).and_return([invalid_goal[0], invalid_goal[1]])
      allow(game_shared).to receive(:puts).with('Choose the goal cell')
      allow_any_instance_of(Player).to receive(:print)
    end

    it "puts 'Invalid move!' " do
      expect(game_shared).to receive(:move_piece).and_return(false)
      game_shared.do_move
    end
  end

  context 'when given a cell occupied by a piece of another color' do
    before do
      @pawn = Pawn.new([valid_goal[0], valid_goal[1]], 'white')
      @pos0 = current_class.position[0]
      @pos1 = current_class.position[1]
      board[@pos0][@pos1] = current_class
      board[valid_goal[0]][valid_goal[1]] = @pawn
      allow_any_instance_of(Player).to receive(:input_piece).and_return([@pos0, @pos1])
      allow_any_instance_of(Player).to receive(:ask_position).and_return([valid_goal[0], valid_goal[1]])
      allow(game_shared).to receive(:puts)
    end

    it 'Moves it to the cell' do
      game_shared.do_move
      expect(board[valid_goal[0]][valid_goal[1]]).to be(current_class)
    end
  end
end

RSpec.shared_examples 'move_piece_occupied_path' do
  let(:game_second_shared) { Game.new }
  let(:pawn) { Pawn.new([valid_goal[0], valid_goal[1]], 'black') }
  let(:board) { game_second_shared.board }

  before do
    allow_any_instance_of(Player).to receive(:puts)
    allow_any_instance_of(Board).to receive(:showboard)
    allow_any_instance_of(Game).to receive(:ask_load)
    allow(game_second_shared).to receive(:ask_input).and_return('black')
    allow(game_second_shared).to receive(:turn_loop)
    game_second_shared.start_game
    allow_any_instance_of(Player).to receive(:text_select_piece)
  end

  context 'when given a cell that is occupied by same color piece' do
    before do
      @pos0 = current_class.position[0]
      @pos1 = current_class.position[1]
      board[@pos0][@pos1] = current_class
      board[valid_goal[0]][valid_goal[1]] = pawn
      allow_any_instance_of(Player).to receive(:input_piece).and_return([@pos0, @pos1])
      allow_any_instance_of(Player).to receive(:ask_position).and_return([valid_goal[0], valid_goal[1]])
      allow(game_second_shared).to receive(:puts)
    end

    it "doesn't update cell" do
      game_second_shared.do_move
      expect(game_second_shared.board[valid_goal[0]][valid_goal[1]]).to be(pawn)
    end
  end

  context 'when given a cell where the path is occupied' do
    before do
      @pos0 = current_class.position[0]
      @pos1 = current_class.position[1]
      board[@pos0][@pos1] = current_class
      board[3][2] = pawn
      allow_any_instance_of(Player).to receive(:input_piece).and_return([@pos0, @pos1])
      allow_any_instance_of(Player).to receive(:ask_position).and_return([valid_goal[0], valid_goal[1]])
    end

    it 'returns false ' do
      expect(game_second_shared).to receive(:do_move).and_return(false)
      game_second_shared.do_move
    end
  end
end
