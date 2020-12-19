require './lib/queen.rb'
require_relative 'shared_examples.rb'

describe Queen do
  describe "#check_move" do
    subject(:queen_check) { described_class.new([0, 4], 'white') }
    let(:board) { Board.new.board }

    context "when given a valid goal" do
      it "returns true" do
        expect(queen_check.check_move([4, 4], board)).to be(true)
      end

      it "returns true" do
        expect(queen_check.check_move([4, 0], board)).to be(true)
      end
    end

    context "when given a valid goal" do
      it "returns false" do
        expect(queen_check.check_move([7, 5], board)).to be(false)
      end

      it "returns false" do
        expect(queen_check.check_move([999, 666], board)).to be(false)
      end
    end
  end

  context "shared_example" do
    include_examples 'move_piece_shared' do 
     let(:current_class) { Queen.new([2,0],'white') }
     let(:valid_goal) { [6, 4] }
     let(:invalid_goal) { ['aaa','eeeffff'] }
    end
  end

  context "shared_example second" do
    include_examples 'move_piece_occupied_path' do 
      let(:current_class) { Queen.new([2,1],'white') }
      let(:valid_goal) { [2, 4] }
      let(:invalid_goal) { [4, 3] }
    end
  end

end
