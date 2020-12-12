require './lib/queen.rb'

describe Queen do
    
    describe "#check_move" do
     subject(:queen_check) { described_class.new([0,4], 'white') }
     let(:board) { Board.new.board }

        context "when given a valid goal" do
            it "returns true" do
                expect(queen_check.check_move([4,4],board)).to be(true)
            end

            it "returns true" do
                expect(queen_check.check_move([4,0],board)).to be(true)              
            end
        end

        context "when given a valid goal" do
            it "returns false" do
                expect(queen_check.check_move([7,5],board)).to be(false)
            end

            it "returns false" do
                expect(queen_check.check_move([999,666],board)).to be(false)              
            end
        end
    end
end