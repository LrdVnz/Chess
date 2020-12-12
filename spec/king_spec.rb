require './lib/king.rb'

describe King do
    
    describe "#check_move" do
     subject(:king_check) { described_class.new([0,3], 'white') }
     let(:board) { Board.new.board }

        context "when given a valid goal" do
            it "returns true" do
                expect(king_check.check_move([0,4],board)).to be(true)
            end

            it "returns true" do
                expect(king_check.check_move([1,3],board)).to be(true)              
            end
        end

        context "when given a valid goal" do
            it "returns false" do
                expect(king_check.check_move([4,4],board)).to be(false)
            end

            it "returns false" do
                expect(king_check.check_move([30,40],board)).to be(false)              
            end
        end
    end
end