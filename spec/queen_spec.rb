# frozen_string_literal: true

Dir['./lib/pieces/*.rb'].sort.each { |file| require file }
require './lib/board'
require_relative 'shared_examples'

describe Queen do
  before do
    allow_any_instance_of(Board).to receive(:showboard)
  end

  describe '#check_move' do
    subject(:queen_check) { described_class.new([0, 4], 'white') }

    let(:board) { Board.new.board }

    context 'when given a valid goal' do
      it 'returns true' do
        allow_any_instance_of(Board).to receive(:init_pieces)
        expect(queen_check.check_move([4, 4], board)).to be(true)
      end

      it 'returns true' do
        allow_any_instance_of(Board).to receive(:init_pieces)
        expect(queen_check.check_move([4, 0], board)).to be(true)
      end
    end

    context 'when given a invalid goal' do
      it 'returns false' do
        expect(queen_check.check_move([7, 5], board)).to be(false)
      end

      it 'returns false' do
        expect(queen_check.check_move([999, 666], board)).to be(false)
      end
    end
  end

  context 'shared_example' do
    include_examples 'move_piece_shared' do
      let(:current_class) { described_class.new([0, 3], 'black') }
      let(:valid_goal) { [1, 2] }
      let(:invalid_goal) { %w[aaa eeeffff] }
    end
  end

  context 'shared_example second' do
    include_examples 'move_piece_occupied_path' do
      let(:current_class) { described_class.new([2, 1], 'black') }
      let(:valid_goal) { [2, 4] }
      let(:invalid_goal) { [4, 3] }
    end
  end
end
