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

  context 'shared_example' do
    include_examples 'move_piece_shared' do
      let(:current_class) { Pawn.new([2, 1], 'white') }
      let(:valid_goal) { [1, 1] }
      let(:invalid_goal) { [0, 7] }
    end
  end
end
