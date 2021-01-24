# frozen_string_literal: true

Dir['./lib/pieces/*.rb'].sort.each { |file| require file }
require './lib/board'
require_relative 'shared_examples'

describe King do
  before(:each) do
    allow_any_instance_of(Board).to receive(:showboard)
  end

  describe '#check_move' do
    subject(:king_check) { described_class.new([0, 4], 'black') }
    let(:board_king) { Board.new }
    let(:board) { board_king.board }

    context 'when given a valid goal' do
      it 'returns true' do
        allow_any_instance_of(Board).to receive(:init_pieces)
        expect(king_check.check_move([0, 5], board)).to be(true)
      end

      it 'returns true' do
        allow_any_instance_of(Board).to receive(:init_pieces)
        expect(king_check.check_move([1, 4], board)).to be(true)
      end
    end

    context 'when given an invalid goal' do
      it 'returns false' do
        expect(king_check.check_move([4, 5], board)).to be(false)
      end

      it 'returns false' do
        expect(king_check.check_move([30, 40], board)).to be(false)
      end
    end
  end

  context 'shared_example' do
    include_examples 'move_piece_shared' do
      let(:current_class) { King.new([0, 4], 'white') }
      let(:valid_goal) { [1, 5] }
      let(:invalid_goal) { [0o000, 99_999] }
    end
  end
end
