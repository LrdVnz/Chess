# frozen_string_literal: true

Dir['./lib/pieces/*.rb'].sort.each { |file| require file }
require './lib/board'
require_relative 'shared_examples'

describe Pawn do
  # please don't hurt me I'm just a little Pawn..

  before(:each) do
    allow_any_instance_of(Board).to receive(:showboard)
  end

  describe '#check_move' do
    subject(:pawn_check) { described_class.new([1, 2], 'black') }
    let(:board) { Board.new.board }

    before(:each) do
      allow_any_instance_of(Pawn).to receive(:save_move)
      File.delete("#{pawn_check.save_move_path}last_pawn_move")
    end

    context 'when given a valid goal' do
      it 'should return true ' do
        expect(pawn_check.check_move([2, 2], board)).to be(true)
      end
    end

    context 'when given an invalid goal' do
      it 'returns false' do
        expect(pawn_check.check_move([9, 9], board)).to be(false)
      end
    end

    context 'when piece is on starting cell' do
      pawn_check_start = Pawn.new([1, 1], 'black')
      it 'makes move 2 steps ahead available' do
        expect(pawn_check_start.check_move([3, 1], board)).to be(true)
      end
    end

    context 'when goal cell is occupied by enemy piece' do
      pawn_check_goal = Pawn.new([5, 2], 'white')

      it 'returns true when move is diagonal' do
        goal = [4, 3]
        enemy_pawn = Pawn.new(goal, 'black')
        board[goal[0]][goal[1]] = enemy_pawn
        board[5][2] = pawn_check_goal
        expect(pawn_check_goal.check_move(goal, board)).to be(true)
      end

      it 'returns false when move is forward' do
        goal = [4, 2]
        enemy_pawn = Pawn.new(goal, 'black')
        board[goal[0]][goal[1]] = enemy_pawn
        board[5][2] = pawn_check_goal
        expect(pawn_check_goal.check_move(goal, board)).to be(false)
      end

      it 'returns true with black pawn too' do
        pawn = Pawn.new([2, 5], 'black')
        goal = [3, 4]
        enemy_pawn = Pawn.new(goal, 'white')
        board[goal[0]][goal[1]] = enemy_pawn
        board[2][5] = pawn
        expect(pawn.check_move(goal, board)).to be(true)
      end

      it 'returns false when pawn in goal cell is same color' do
        pawn = Pawn.new([2, 5], 'black')
        goal = [3, 4]
        enemy_pawn = Pawn.new(goal, 'black')
        board[goal[0]][goal[1]] = enemy_pawn
        board[2][5] = pawn
        expect(pawn.check_move(goal, board)).to be(false)
      end
    end
  end

  describe '#save_move' do
    subject(:pawn_save) { described_class.new([1, 2], 'black') }

    after(:each) do
      File.delete("#{pawn_save.save_move_path}last_pawn_move")
    end

    context 'when saving the move' do
      it 'saves and overwrites the file' do
        double_step = pawn_save.moves['double_step']
        pawn_save.save_move(double_step)
        expect(File).to exist("#{pawn_save.save_move_path}last_pawn_move")
      end
    end
  end

  describe '#load_move' do
    subject(:pawn_load) { described_class.new([1, 2], 'black') }

    context 'when loading a move' do
      it 'loads correctly' do
        sample_pawn = Pawn.new([6, 3], 'white')
        sample_pawn.save_move(sample_pawn.moves['double_step'])
        pawn_load.load_move([4, 3])
        previous_move = pawn_load.instance_variable_get(:@previous_move)
        expect(previous_move['color']).to eq('white')
      end
    end
  end

  describe '#en_passant' do
    before do
      allow_any_instance_of(Board).to receive(:init_pieces)
    end

    subject(:pawn_enpassant) { described_class.new([4, 2], 'black') }
    let(:board) { Board.new.board }

    context 'when doing an en passant' do
      before(:each) do
        sample_pawn = Pawn.new([6, 3], 'white')
        board[6][3] = sample_pawn
        board[4][2] = pawn_enpassant
        sample_pawn.save_move(sample_pawn.moves['double_step'])
      end

      it 'returns true' do
        expect(pawn_enpassant.en_passant([5, 3], board)).to be_instance_of(Hash)
      end
    end
  end

  context 'shared_example' do
    before(:each) do
      allow_any_instance_of(Pawn).to receive(:save_move)
    end

    include_examples 'move_piece_shared' do
      let(:current_class) { Pawn.new([1, 5], 'black') }
      let(:valid_goal) { [2, 6] }
      let(:invalid_goal) { [0, 7] }
    end
  end
end
