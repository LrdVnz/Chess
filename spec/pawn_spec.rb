require './lib/pawn.rb'
require_relative 'shared_examples.rb'

describe Pawn do
  # please don't hurt me I'm just a little Pawn..

  describe "#check_move" do
    subject(:pawn_check) { described_class.new([1, 2], 'white') }
    let(:board) { Board.new.board }

    context "when given a valid goal" do
      it "should return true " do
        expect(pawn_check.check_move([2, 2], board)).to be(true)
      end
    end

    context "when given an invalid goal" do
      it "returns false" do
        expect(pawn_check.check_move([9, 9], board)).to be(false)
      end
    end

    context "when piece is on starting cell" do 
      pawn_check_start = Pawn.new([1,1], 'black')   
         it "makes move 2 steps ahead available" do
          expect(pawn_check_start.check_move([3,1], board)).to be(true)  
         end
    end
  end

  context "shared_example" do
    include_examples 'move_piece_shared' do 
     let(:current_class) { Pawn.new([2,0],'white') }
     let(:valid_goal) { [3,0] }
     let(:invalid_goal) { [0,7] }
    end
  end

end
