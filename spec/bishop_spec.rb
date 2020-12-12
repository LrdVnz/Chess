require './lib/bishop.rb'

describe Bishop do
    describe "#check_move" do
     subject(:bishop_check) { described_class.new([0,2], 'white') }
     let(:board) { Board.new.board }

        context "when given valid goal" do
            it "returns true" do
             expect(bishop_check.check_move([5,7], board)).to be(true) 
            end

            it "returns true" do
                expect(bishop_check.check_move([2,0], board)).to be(true) 
            end
        end
        
        context "when given invalid goal" do
            it "returns false" do
               expect(bishop_check.check_move([2,7], board)).to be(false) 
            end

            it "returns false" do
                expect(bishop_check.check_move([-20,-90], board)).to be(false) 
            end
        end
    end

end