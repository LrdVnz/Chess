require './lib/pawn.rb'

describe Pawn do 
#please don't hurt me I'm just a little Pawn..
   
  describe "#initialize" do
    #initialize method. No need for testing
  end

  describe "#check_move" do
    subject(:pawn_check) { described_class.new([1,2], 'white') }
     
    context "when given a valid goal" do
     it "should return true " do  
      expect(pawn_check.check_move([2,2])).to be(true)      
     end
    end

    context "when given an invalid goal" do
      it "returns false" do
        expect(pawn_check.check_move([9,9])).to be(false)
      end
    end
  end


end