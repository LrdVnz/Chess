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
            expect(Knight).to receive(:new).with([0,1], 'white')
            expect(board_set_piece).to receive(:insert_piece)
            board_set_piece.create_piece(Knight, [0,1], 'white') 
         end 
      end
  end

  describe "#put_piece" do
    subject(:board_put_piece) { described_class.new }
    let(:knight) { Knight.new([0,1], 'white') }

    context "when giving a knight" do
        it "puts it on the chosen position on the board" do
          board = board_put_piece.board
          board_put_piece.insert_piece(knight,0,1)
          expect(board[0][1]).to be_instance_of(Knight)        
        end
    end
  end

  describe "#get_position" do
   subject(:board_get_position) { described_class.new }

    context "when given correct values" do
      it "returns the two values in the array" do
        allow(board_get_position).to receive(:gets).and_return(2,2)
        expect(board_get_position).to receive(:get_position).and_return([2,2])
        board_get_position.get_position
      end
    end

    context "when given wrong first value and then right, then correct ones" do
       it "returns error message first, then values in array" do
        error_message = "Input error! Choose a row and a column, from 0 to 7"
        allow(board_get_position).to receive(:gets).with(34, 2)
        allow(board_get_position).to receive(:gets).with(2, 2)
        expect(board_get_position).to receive(:get_position).and_return(error_message, [2,2])
        board_get_position.get_position
        board_get_position.get_position
        end
    end

    context "when given wron values two times, then correct ones" do
      it "returns error message twice, then values in array" do
       error_message = "Input error! Choose a row and a column, from 0 to 7"
       allow(board_get_position).to receive(:gets).with(34, 2)
       allow(board_get_position).to receive(:gets).with(99999, 'aajahahha')
       allow(board_get_position).to receive(:gets).with(2, 2)
       expect(board_get_position).to receive(:get_position).and_return(error_message, error_message, [2,2])       
       board_get_position.get_position
       board_get_position.get_position
       board_get_position.get_position
       end
   end
  end
end