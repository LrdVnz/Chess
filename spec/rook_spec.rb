require './lib/rook.rb'
require_relative 'board_spec.rb'

 describe Rook do
       
    describe "#initialize" do 
        #initalize. Same for all pieces, no need for testing
    end

    describe "#check_move" do
     subject(:tower_check) { described_class.new([0,0], 'white') }
     let(:board) { Board.new.board }

      context "when given a valid goal" do
         it "returns true" do
            expect(tower_check.check_move([4,0],board)).to be(true)
         end

         it "returns true" do
            expect(tower_check.check_move([0,7],board)).to be(true)
         end
      end

      context "when given an invalid goal" do
         it "returns false" do
            expect(tower_check.check_move([4,4],board)).to be(false)
         end
      end
    end

 end