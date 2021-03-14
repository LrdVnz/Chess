# frozen_string_literal: true

require './lib/board'

describe Board do
  before(:each) do
    allow_any_instance_of(Board).to receive(:showboard)
    allow_any_instance_of(Board).to receive(:puts)
  end

  describe '#initialize' do
    subject(:board_new) { described_class.new }

    context 'when creating the board' do
      it 'should create 8 x 8 board' do
        board = board_new.board
        expect(board).to be_instance_of(Array)
        expect(board.length).to eq(8)
        expect(board.all? { |row| row.length == 8 }).to be(true)
      end
    end
  end

  describe '#set_piece' do
    subject(:board_set_piece) { described_class.new }

    before(:each) do
      allow_any_instance_of(Board).to receive(:init_pieces)
    end

    context 'when chosen piece is Knight' do
      it 'creates a new knight and calls put_piece' do
        allow_any_instance_of(Board).to receive(:init_pieces)
        expect(Knight).to receive(:new).with([0, 1], 'white')
        expect(board_set_piece).to receive(:insert_piece)
        board_set_piece.create_piece(Knight, [0, 1], 'white')
      end
    end
  end

  describe '#put_piece' do
    subject(:board_put_piece) { described_class.new }
    let(:knight) { Knight.new([0, 1], 'black') }

    before(:each) do
      allow_any_instance_of(Board).to receive(:init_pieces)
    end

    context 'when giving a knight' do
      it 'puts it on the chosen position on the board' do
        board = board_put_piece.board
        board_put_piece.insert_piece(knight, 0, 1)
        expect(board[0][1]).to be_instance_of(Knight)
      end
    end
  end

  describe '#get_position' do
    subject(:board_get_position) { described_class.new }

    before(:each) do
      allow_any_instance_of(Board).to receive(:init_pieces)
    end

    context 'when given correct values' do
      it 'returns the two values in the array' do
        allow(board_get_position).to receive(:gets).and_return(2, 2)
        expect(board_get_position).to receive(:get_position).and_return([2, 2])
        board_get_position.get_position
      end
    end

    context 'when given wrong first value and then right, then correct ones' do
      it 'returns error message first, then values in array' do
        error_message = 'Input error! Choose a row and a column, from 0 to 7'
        allow(board_get_position).to receive(:gets).with(34, 2)
        allow(board_get_position).to receive(:gets).with(2, 2)
        expect(board_get_position).to receive(:get_position).and_return(error_message, [2, 2])
        board_get_position.get_position
        board_get_position.get_position
      end
    end

    context 'when given wrong values two times, then correct ones' do
      it 'returns error message twice, then values in array' do
        error_message = 'Input error! Choose a row and a column, from 0 to 7'
        allow(board_get_position).to receive(:gets).with(34, 2)
        allow(board_get_position).to receive(:gets).with(99_999, 'aajahahha')
        allow(board_get_position).to receive(:gets).with(2, 2)
        expect(board_get_position).to receive(:get_position).and_return(error_message, error_message, [2, 2])
        board_get_position.get_position
        board_get_position.get_position
        board_get_position.get_position
      end
    end
  end

  context 'pawn promotion' do
    before do
      allow_any_instance_of(Board).to receive(:init_pieces)
    end

    describe '#promote_pawn' do
      subject(:board_promote) { described_class.new }
      let(:pawn_promote) { Pawn.new([0, 1], 'white') }

      context 'when promoting a pawn' do
        before do
          pos0 = pawn_promote.position[0]
          pos1 = pawn_promote.position[1] 
          board_promote.insert_piece(pawn_promote, pos0, pos1)
        end

        it 'correctly trasforms in a queen' do
          allow(board_promote).to receive(:gets).and_return('queen')
          board_promote.promote_pawn(pawn_promote, [0, 1])
          expect(board_promote.board[0][1]).to be_instance_of(Queen)
        end

        it 'correctly trasforms in a rook' do
          allow(board_promote).to receive(:gets).and_return('rook')
          board_promote.promote_pawn(pawn_promote, [0, 1])
          expect(board_promote.board[0][1]).to be_instance_of(Rook)
        end
      end
    end
  end
 
end
