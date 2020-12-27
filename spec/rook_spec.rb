Dir["./lib/pieces/*.rb"].each {|file| require file }
require './lib/board.rb'
require_relative 'shared_examples.rb'

describe Rook do

  describe "#check_move" do
    subject(:tower_check) { described_class.new([0, 0], 'white') }
    let(:board) { Board.new.board }

    context "when given a valid goal" do
      it "returns true" do
        allow_any_instance_of(Board).to receive(:init_pieces)
        expect(tower_check.check_move([4, 0], board)).to be(true)
      end

      it "returns true" do
        allow_any_instance_of(Board).to receive(:init_pieces)
        expect(tower_check.check_move([0, 7], board)).to be(true)
      end
    end

    context "when given an invalid goal" do
      it "returns false" do
        expect(tower_check.check_move([4, 4], board)).to be(false)
      end
    end
  end
  
  context "shared_example first" do
    include_examples 'move_piece_shared' do 
     let(:current_class) { Rook.new([2,0],'white') }
     let(:valid_goal) { [5, 0] }
     let(:invalid_goal) { ['dqwwwq',20200202] }
    end
  end

    context "shared example second" do
      include_examples "move_piece_occupied_path" do
        let(:current_class) { Rook.new([2,2],'white') }
        let(:invalid_goal) { [7, 2] }
        let(:valid_goal) { [2, 5] }
      end
    end

end
