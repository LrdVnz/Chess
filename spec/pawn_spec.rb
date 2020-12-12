require './lib/pawn.rb'
require_relative 'board_spec.rb'

describe Pawn do 
#please don't hurt me I'm just a little Pawn..

  describe "#check_move" do
    subject(:pawn_check) { described_class.new([1,2], 'white') }
    let(:board) { Board.new.board }

    context "when given a valid goal" do
     it "should return true " do  
      expect(pawn_check.check_move([2,2], board)).to be(true)      
     end
    end

    context "when given an invalid goal" do
      it "returns false" do
        expect(pawn_check.check_move([9,9], board)).to be(false)
      end
    end
  end

end