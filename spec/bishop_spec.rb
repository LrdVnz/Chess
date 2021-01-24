# frozen_string_literal: true

Dir['./lib/pieces/*.rb'].sort.each { |file| require file }
require './lib/board'
require_relative 'shared_examples'

describe Bishop do
  before(:each) do
    # allow_any_instance_of(Board).to receive(:showboard)
  end

  describe '#check_move' do
    subject(:bishop_check) { described_class.new([0, 2], 'black') }
    let(:board) { Board.new.board }

    context 'when given valid goal' do
      it 'returns true' do
        allow_any_instance_of(Board).to receive(:init_pieces)
        expect(bishop_check.check_move([5, 7], board)).to be(true)
      end

      it 'returns true again' do
        allow_any_instance_of(Board).to receive(:init_pieces)
        board[0][2] = bishop_check
        expect(bishop_check.check_move([2, 0], board)).to be(true)
      end
    end

    context 'when given invalid goal' do
      it 'returns false' do
        expect(bishop_check.check_move([2, 7], board)).to be(false)
      end

      it 'returns false' do
        expect(bishop_check.check_move([-20, -90], board)).to be(false)
      end
    end
  end

  context 'shared_example' do
    include_examples 'move_piece_shared' do
      let(:current_class) { Bishop.new([0, 2], 'black') }
      let(:valid_goal) { [1, 3] }
      let(:invalid_goal) { [10, 50] }
    end
  end

  context 'shared_example second' do
    include_examples 'move_piece_occupied_path' do
      let(:current_class) { Bishop.new([0, 5], 'black') }
      let(:valid_goal) { [3, 2] }
      let(:invalid_goal) { [5, 4] }
    end
  end
end
