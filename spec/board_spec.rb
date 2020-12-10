require './lib/board.rb'

describe Board do
       
  describe "#initialize" do
    subject(:board_new) { described_class.new }
    context "when creating the board" do
       it "should create 8 x 8 board" do
         board = board_new.board
          expect(board).to be_instance_of(Array)
          expect(board.length).to eq(8)
          expect(board.all? {|row| row.length == 8}).to be(true)
       end
    end

  end


end