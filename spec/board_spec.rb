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

  describe "#set_piece" do 
   subject(:board_set_piece) { described_class.new }

      context "when chosen piece is Knight" do
         it "creates a new knight and calls put_piece" do
            expect(Knight).to receive(:new).with(0, 1, 'white')
            expect(board_set_piece).to receive(:put_piece)
            board_set_piece.set_piece(Knight, 0, 1, 'white') 
         end 
      end
  end

  describe "#put_piece" do
    subject(:board_put_piece) { described_class.new }
    let(:knight) { Knight.new(0,1,'white') }

    context "when choosing a piece" do
        it "puts it on the chosen position on the board" do
          board = board_put_piece.board
          board_put_piece.put_piece(knight, 0, 1)
          expect(board[0][1]).to be_instance_of(Knight)        
        end
    end
  end

  

end