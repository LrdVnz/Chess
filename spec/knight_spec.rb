# frozen_string_literal: true

Dir['./lib/pieces/*.rb'].sort.each { |file| require file }
require './lib/board'
require_relative 'shared_examples'

describe Knight do
  before do
    allow_any_instance_of(Board).to receive(:showboard)
  end

  describe '#check_move' do
    subject(:knight_check) { described_class.new([0, 6], 'white') }

    let(:board) { Board.new.board }

    context 'when the player inputs valid goal' do
      it 'returns true if the move is possible' do
        expect(knight_check.check_move([2, 5], board)).to be(true)
      end

      it 'returns nil if move is not possible' do
        expect(knight_check.check_move([3, 5], board)).to be(false)
      end
    end
  end

  context 'shared_example' do
    include_examples 'move_piece_shared' do
      let(:current_class) { described_class.new([0, 1], 'black') }
      let(:valid_goal) { [2, 2] }
      let(:invalid_goal) { [899, 1213] }
    end
  end
end
