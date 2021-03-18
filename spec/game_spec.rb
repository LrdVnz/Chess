# frozen_string_literal: true

require './lib/game'
describe Game do
  before do
    allow_any_instance_of(described_class).to receive(:puts)
    allow_any_instance_of(Player).to receive(:puts)
    allow_any_instance_of(described_class).to receive(:ask_load)
    allow_any_instance_of(Board).to receive(:showboard)
    allow_any_instance_of(described_class).to receive(:ask_save)
  end

  describe '#start_game' do
    subject(:game_start) { described_class.new }
    let(:sample_piece) { Pawn.new([1, 3], 'black') }

    before do 
     allow(game_start).to receive(:puts)
    end

    context 'when given a valid input' do
      before do
        allow(game_start).to receive(:ask_input).and_return('white')
        allow(game_start).to receive(:turn_loop)
      end

      it 'creates the player' do
        game_start.start_game
        expect(game_start.p1.color).to eq('white')
      end
    end

    context 'when given an invalid input once' do
      before do
        allow(game_start).to receive(:gets).and_return('aaaaaaa', 'white')
        allow(game_start).to receive(:turn_loop)
      end

      it 'puts error message' do
        initial_message = 'Choose your color. Black or White.'

        expect(game_start).to receive(:puts).with(initial_message).twice
        game_start.start_game
      end
    end

    context 'when playing a turn with a valid move' do
      before do
        allow(game_start).to receive(:ask_input).and_return('white')
        allow_any_instance_of(Player).to receive(:text_select_piece)
        allow_any_instance_of(Player).to receive(:select_piece).and_return(sample_piece)
        allow_any_instance_of(Player).to receive(:ask_position).and_return([2, 3])
        allow(game_start).to receive(:win?).and_return(true)
      end

      it 'changes turn and current_player' do
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
        game_turn.instance_variable_set(:@p1, p1)
        game_turn.instance_variable_set(:@p2, p2)
        allow_any_instance_of(Player).to receive(:do_move).and_return(false, true)
        allow_any_instance_of(Board).to receive(:showboard)
        allow(game_turn).to receive(:do_move).and_return(false)
        allow(game_turn).to receive(:verify_checkmate)
        allow(game_turn).to receive(:win?).and_return(false, true)
      end

      it "doesn't update turns" do
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

      it 'plays correctly' do
        whitePawn = Pawn.new([4, 4], 'white')
        blackPawn = Pawn.new([3, 3], 'black')
        game_turn.board[4][4] = whitePawn
        game_turn.board[3][3] = blackPawn
        allow(p1).to receive(:select_piece).and_return(whitePawn)
        allow(p1).to receive(:ask_position).and_return([3, 3])
        allow(game_turn).to receive(:win?).and_return(true)
        game_turn.turn_loop
        expect(game_turn.board[3][3]).to be(whitePawn)
      end
    end
  end

  describe '#get_enemy_pieces' do
    subject(:game_get_enemy) { described_class.new }

    let(:turns_start) { game_turn.turns }

    context "when the enemy is of 'black' color" do
      before do
        allow(game_get_enemy).to receive(:ask_input).and_return('white')
        allow(game_get_enemy).to receive(:turn_loop)
        game_get_enemy.start_game
        allow_any_instance_of(Player).to receive(:text_select_piece)
      end

      it 'returns only black pieces' do
        enemy_pieces = game_get_enemy.all_enemy_pieces
        expect(enemy_pieces.flatten.all? { |piece| piece.color == 'black' }).to be(true)
      end
    end

    context "when the enemy is of 'white' color" do
      before do
        allow(game_get_enemy).to receive(:ask_input).and_return('black')
        allow(game_get_enemy).to receive(:turn_loop)
        game_get_enemy.start_game
        allow_any_instance_of(Player).to receive(:text_select_piece)
      end

      it 'returns only white pieces' do
        enemy_pieces = game_get_enemy.all_enemy_pieces
        expect(enemy_pieces.flatten.all? { |piece| piece.color == 'white' }).to be(true)
      end
    end
  end

  describe '#all_possible_moves' do
    let(:game_possible_moves) { described_class.new }
    let(:turns_start) { game_turn.turns }

    before do
      allow(game_possible_moves).to receive(:ask_input).and_return('black')
      allow(game_possible_moves).to receive(:turn_loop)
      game_possible_moves.start_game
      allow_any_instance_of(Player).to receive(:text_select_piece)
      game_possible_moves.instance_variable_set(:@enemy_pieces, game_possible_moves.all_enemy_pieces)
    end

    context 'when given the enemy pieces' do
      it 'calculates all possible moves' do
        moves = game_possible_moves.all_possible_moves
        expect(moves).to be_instance_of(Array)
      end
    end
  end

  describe '#verify_king_check' do
    let(:game_king_check) { described_class.new }
    let(:turns_start) { game_turn.turns }

    before do
      allow(game_king_check).to receive(:ask_input).and_return('black')
      allow(game_king_check).to receive(:turn_loop)
      game_king_check.start_game
      allow_any_instance_of(Player).to receive(:text_select_piece)
    end

    context "when king isn't in check" do
      it 'returns false' do
        expect(game_king_check.verify_king_check).to be(false)
      end
    end

    context 'when king is in check' do
      before do
        game_king_check.board[5][0] = King.new([5, 0], 'black')
      end

      it 'returns true' do
        expect(game_king_check.verify_king_check).to be(true)
      end
    end
  end

  describe '#verify_checkmate' do
    before do
      allow_any_instance_of(Board).to receive(:init_pieces)
      allow_any_instance_of(described_class).to receive(:turn_loop)
      allow_any_instance_of(Player).to receive(:text_select_piece)
    end

    context 'when black king is in checkmate' do
      let(:game_checkmate_white) { described_class.new }

      before do
        allow(game_checkmate_white).to receive(:ask_input).and_return('black')
        game_checkmate_white.start_game
        game_checkmate_white.board[0][2] = Rook.new([0, 2], 'white')
        game_checkmate_white.board[3][2] = Bishop.new([3, 2], 'white')
        game_checkmate_white.board[3][5] = Queen.new([3, 5], 'white')
        game_checkmate_white.board[1][4] = King.new([1, 4], 'black')
      end

      it 'makes enemy the winner' do
        game_checkmate_white.verify_checkmate
        expect(game_checkmate_white.winner).to eq(game_checkmate_white.enemy)
      end
    end

    context 'when white king is in checkmate' do
      let(:game_checkmate_black) { described_class.new }

      before do
        allow(game_checkmate_black).to receive(:ask_input).and_return('white')
        game_checkmate_black.start_game
        game_checkmate_black.board[3][0] = Queen.new([3, 0], 'black')
        game_checkmate_black.board[7][5] = Bishop.new([7, 5], 'white')
        game_checkmate_black.board[7][3] = Queen.new([7, 3], 'white')
        game_checkmate_black.board[7][4] = King.new([7, 4], 'white')
        game_checkmate_black.board[6][4] = Pawn.new([6, 4], 'white')
        game_checkmate_black.board[6][5] = Pawn.new([6, 5], 'white')
      end

      it 'makes enemy the winner' do
        game_checkmate_black.verify_checkmate
        expect(game_checkmate_black.winner).to be(game_checkmate_black.enemy)
      end
    end

    context 'when king is in check but not in checkmate' do
      let(:game_nomate) { described_class.new }

      before do
        allow(game_nomate).to receive(:ask_input).and_return('black')
        game_nomate.start_game
        game_nomate.board[1][2] = King.new([1, 2], 'black')
        game_nomate.board[2][1] = Queen.new([2, 1], 'white')
        game_nomate.board[3][2] = Rook.new([3, 2], 'white')
        allow_any_instance_of(Player).to receive(:ask_position).and_return([1, 3])
      end

      it 'lets the king move away from check' do
        game_nomate.verify_checkmate
        expect(game_nomate.board[1][3]).to be_instance_of(King)
      end
    end
  end

  describe '#verify_stalemate' do
    before do
      allow_any_instance_of(Board).to receive(:init_pieces)
      allow_any_instance_of(described_class).to receive(:ask_input).and_return('black')
      allow_any_instance_of(described_class).to receive(:turn_loop)
      allow_any_instance_of(Player).to receive(:text_select_piece)
    end

    context 'when king is in stalemate' do
      let(:game_stalemate) { described_class.new }

      before do
        game_stalemate.start_game
        game_stalemate.board[1][2] = Queen.new([1, 2], 'white')
        game_stalemate.board[0][0] = King.new([0, 0], 'black')
      end

      it 'ends the game' do
        game_stalemate.verify_stalemate
        expect(game_stalemate.won).to be(true)
      end
    end

    context 'when king is in stalemate by two pieces ' do
      let(:game_stalemate_two) { described_class.new }

      before do
        game_stalemate_two.start_game
        game_stalemate_two.board[2][6] = Rook.new([2, 6], 'white')
        game_stalemate_two.board[0][7] = King.new([0, 7], 'black')
        game_stalemate_two.board[2][7] = King.new([2, 7], 'white')
      end

      it 'ends the game' do
        game_stalemate_two.verify_stalemate
        expect(game_stalemate_two.won).to be(true)
      end
    end
  end
  
  context 'en-passant' do
    describe '#move_piece' do
      context 'when making an en passant move with black' do
        subject(:game_enpassant_black) { described_class.new }

        let(:board) { game_enpassant_black.board }

        let(:pawn_enpassant_black) { Pawn.new([4, 6], 'black') }

        before do
          allow(game_enpassant_black).to receive(:ask_load)
          allow(game_enpassant_black).to receive(:ask_input).and_return('black')
          allow(game_enpassant_black).to receive(:turn_loop)
          game_enpassant_black.start_game
          sample_pawn = Pawn.new([6, 5], 'white')
          board[6][5] = sample_pawn
          board[4][6] = pawn_enpassant_black
          game_enpassant_black.move_piece(sample_pawn, [4, 5], board)
        end

        it 'moves the piece correctly' do
          game_enpassant_black.move_piece(pawn_enpassant_black, [5, 5], game_enpassant_black.board,
                                          game_enpassant_black.turns)
          expect(board[5][5]).to be(pawn_enpassant_black)
        end

        it 'removes the enemy piece' do
          game_enpassant_black.move_piece(pawn_enpassant_black, [5, 5], game_enpassant_black.board,
                                          game_enpassant_black.turns)
          expect(board[4][5]).to eq(' ')
        end
      end

      context 'when making an en-passant in a real setting' do
        subject(:game_enpassant_real) { described_class.new }

        let(:pawn_enpassant_real) { Pawn.new([3, 2], 'white') }
        let(:board) { game_enpassant_real.board }

        before do
          sample_pawn = Pawn.new([1, 3], 'black')
          board[1][3] = sample_pawn
          board[3][2] = pawn_enpassant_real
          allow(game_enpassant_real).to receive(:ask_load)
          allow(game_enpassant_real).to receive(:ask_input).and_return('white')
          allow(game_enpassant_real).to receive(:turn_loop).twice
          game_enpassant_real.start_game
          game_enpassant_real.move_piece(sample_pawn, [3, 3], board)
        end

        it 'moves the piece correctly' do
          game_enpassant_real.move_piece(pawn_enpassant_real, [2, 3], game_enpassant_real.board,
                                         game_enpassant_real.turns)
          expect(board[2][3]).to be(pawn_enpassant_real)
        end

        it 'removes the enemy piece' do
          game_enpassant_real.move_piece(pawn_enpassant_real, [2, 3], game_enpassant_real.board,
                                         game_enpassant_real.turns)
          expect(board[3][3]).to eq(' ')
        end
      end
    end
  end

  context 'Save game module' do
    describe '#save' do
      subject(:game_save) { described_class.new }

      after do
        File.delete("#{game_save.saves_path}save2")
      end

      context 'when saving a game' do
        it 'correctly creates the save file' do
          allow(game_save).to receive(:gets).and_return('save2')
          game_save.save
          expect(File).to exist("#{game_save.saves_path}save2")
        end
      end
    end

    describe '#load' do
      subject(:game_load) { described_class.new }

      context 'when loading a game' do
        it 'loads the file correctly' do
          p1 = game_load.p1
          p2 = game_load.p2
          allow(game_load).to receive(:gets).and_return('save_sample', 'save_sample')
          game_load.save
          game_load.load
          expect(game_load.p1).to be(p1)
        end
      end
    end
  end

  context 'castling' do
    describe '#check_castling' do
      subject(:game_castling) { described_class.new }

      before do
        allow(game_castling).to receive(:ask_input).and_return('white')
        allow(game_castling).to receive(:turn_loop)
        game_castling.start_game
      end

      context 'when doing castling right' do
        it 'moves pieces correctly' do
          current_player = game_castling.current_player
          king_castling = King.new([7, 4], 'white')
          rook_castling = Rook.new([7, 7], 'white')
          game_castling.board[7][4] = king_castling
          game_castling.board[7][7] = rook_castling
          game_castling.board[7][5] = ' '
          game_castling.board[7][6] = ' '
          allow(current_player).to receive(:select_piece).and_return(king_castling)
          allow(current_player).to receive(:ask_position).and_return([7, 6])
          game_castling.do_move
          expect(game_castling.board[7][6]).to be(king_castling)
          expect(game_castling.board[7][5]).to be(rook_castling)
        end
      end
    end
  end
end
