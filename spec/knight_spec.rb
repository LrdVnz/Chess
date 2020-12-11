require './lib/knight.rb'
require_relative 'board_spec.rb'

describe Knight do
   
    describe "#initialize" do
      #just setters. No need to test
    end
    
    describe "#check_move" do #maybe it will be a method shared and tested between all the pieces ? 
      subject(:knight_check) { described_class.new([0,6], 'white')}

        context "when the player inputs valid goal" do
            it "returns true if the move is possible" do
              expect(knight_check.check_move([2,5])).to be(true)
            end

            it "returns nil if move is not possible" do
                expect(knight_check.check_move([3,5])).to be(false)
            end
        end
    end

    describe "#make_move" do
       #already tested with check_move
    end

end