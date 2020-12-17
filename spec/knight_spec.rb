require './lib/knight.rb'
require_relative 'shared_examples.rb'

describe Knight do

  describe "#check_move" do 
    subject(:knight_check) { described_class.new([0, 6], 'white') }
    let(:board) { Board.new.board }

    context "when the player inputs valid goal" do
      it "returns true if the move is possible" do
        expect(knight_check.check_move([2, 5], board)).to be(true)
      end

      it "returns nil if move is not possible" do
        expect(knight_check.check_move([3, 5], board)).to be(false)
      end
    end
  end

  context "shared_example" do
    include_examples 'move_piece_shared' do 
     let(:current_class) { Knight.new([2,0],'white') }
     let(:valid_goal) { [4, 1] }
     let(:invalid_goal) { [0,0] }
    end
  end

end
