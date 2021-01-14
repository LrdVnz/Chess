# frozen_string_literal: true

require './lib/game'
#gotta modify all calls to "move_piece" to add the argument "turns"...
describe Game do
  before(:each) do
  allow_any_instance_of(Game).to receive(:puts)
  allow_any_instance_of(Player).to receive(:puts)
  allow_any_instance_of(Game).to receive(:ask_load)
  end

  describe '#start_game' do
    subject(:game_start) { described_class.new }
    let(:sample_piece) { Pawn.new([1, 3], 'black') }

    before(:each) do
      allow_any_instance_of(Board).to receive(:showboard)
    end

    context 'when given a valid input' do
      it 'creates the player' do
        allow(game_start).to receive(:ask_input).and_return('white')
        allow(game_start).to receive(:turn_loop)
        game_start.start_game
        expect(game_start.p1.color).to eq('white')
      end
    end

    context 'when given an invalid input once' do
      it 'puts error message' do
        initial_message = 'Choose your color. Black or White.'
        allow(game_start).to receive(:gets).and_return('aaaaaaa', 'white')
        allow(game_start).to receive(:turn_loop)
        expect(game_start).to receive(:puts).with(initial_message).twice
        game_start.start_game
      end
    end

    context 'when playing a turn with a valid move' do
      it 'changes turn and current_player' do
        allow(game_start).to receive(:ask_input).and_return('white')
        allow_any_instance_of(Player).to receive(:text_select_piece)
        allow_any_instance_of(Player).to receive(:select_piece).and_return(sample_piece)
        allow_any_instance_of(Player).to receive(:ask_position).and_return([2, 3])
        allow(game_start).to receive(:win?).and_return(true)
        game_start.start_game
        expect(game_start.board[2][3]).to be_instance_of(Pawn)
        expect(game_start.turns).to eq(2)
      end
    end
  end

  describe '#turn_loop' do
    subject(:game_turn) { described_class.new }
    let(:turns_start) { game_turn.turns }
    let(:p1) { Player.new('white') }
    let(:p2) { Player.new('black') }

    context 'when making an invalid move' do
      before do
        game_turn.instance_variable_set(:@current_player, p1)
        allow_any_instance_of(Player).to receive(:do_move).and_return(false, true)
        allow_any_instance_of(Board).to receive(:showboard)
      end

      it "doesn't update turns" do
        allow(game_turn).to receive(:do_move)
        allow(game_turn).to receive(:win?).and_return(false, true)
        expect(game_turn.turns).to eq(turns_start)
        game_turn.turn_loop
      end
    end
    
    context 'when making a move to eat an enemy piece' do
       before do 
        game_turn.instance_variable_set(:@current_player, p1)
        game_turn.instance_variable_set(:@p1, p1)
        game_turn.instance_variable_set(:@p2, p2)
        allow_any_instance_of(Board).to receive(:showboard)
       end

      it "plays correctly" do
        whitePawn = Pawn.new([4,4], 'white')
        blackPawn = Pawn.new([3,3], 'black')
        game_turn.board[4][4] = whitePawn
        game_turn.board[3][3] = blackPawn
        allow(p1).to receive(:select_piece).and_return(whitePawn)
        allow(p1).to receive(:ask_position).and_return([3,3])
        allow(game_turn).to receive(:win?).and_return(true)
        game_turn.turn_loop
        expect(game_turn.board[3][3]).to be(whitePawn)
      end
    end
  end

  context 'Save game module' do
    describe '#save' do
      subject(:game_save) { described_class.new }

      context 'when saving a game' do
        it 'correctly creates the save file' do
          allow(game_save).to receive(:gets).and_return('save2')
          game_save.save
          expect(File).to exist("#{game_save.saves_path}save2")
        end
      end
    end

    describe "#load" do
     subject(:game_load) { described_class.new }

      context "when loading a game" do
        it "loads the file correctly" do
          p1 = game_load.p1
          p2 = game_load.p2
          allow(game_load).to receive(:gets).and_return('save1', 'save1')
          game_load.save
          game_load.load
          expect(game_load.p1).to be(p1)
        end
      end
    end
  end
end
