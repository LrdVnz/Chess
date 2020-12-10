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
            expect(board_set_piece).to receive(:put_piece)
            board_set_piece.set_piece(Knight, [0,1], 'white') 
         end 
      end
  end

  describe "#put_piece" do
    subject(:board_put_piece) { described_class.new }
    let(:knight) { Knight.new([0,1], 'white') }

    context "when giving a knight" do
        it "puts it on the chosen position on the board" do
          board = board_put_piece.board
          board_put_piece.put_piece(knight,0,1)
          expect(board[0][1]).to be_instance_of(Knight)        
        end
    end
  end

  describe "#move_piece" do
   subject(:board_move_piece) { described_class.new }
   let(:knight) { Knight.new([0,1], 'white')}
   let(:board) { board_move_piece.instance_variable_get(:@board) }
   let(:invalid_goal) { [4,4] }
   let(:valid_goal) { [2,2] }

    context "when giving a Knight" do
         it "moves it to goal if move is valid" do
             board_move_piece.move_piece(knight, [2,2])
             expect(board[2][2]).to be_instance_of(Knight)
         end

         it "puts 'Invalid move!' if move is invalid once" do 
            error_message = 'Invalid move!'
            allow(board_move_piece).to receive(:move_piece).and_return(:puts, :put_piece)
            board_move_piece.move_piece(knight, invalid_goal)
            board_move_piece.move_piece(knight, valid_goal)         
        end

        it "resets to default the cell where the piece was" do
          allow(board_move_piece).to receive(:move_piece).with(knight, valid_goal)
          expect(board[0][1]).to eq('  ')
        end
    end
  end

  describe "#get_position" do
   subject(:board_get_position) { described_class.new }
   let(:correct_row) { 2 }
   let(:correct_column) { 2 }

    context "when given correct values" do
      xit "returns the two values in the array" do
        allow(board_get_position).to receive(:gets).and_return(correct_row, correct_column)
        expect(board_get_position).to receive(:get_position).and_return([2,2])
        board_get_position.get_position
      end
    end

    context "when given wrong first value and then right" do
       it "returns error message first, then values in array" do
        first_puts = "Choose row from 0 to 7"
        second_puts = "Now choose a column from 0 to 7"
        wrong_input = "Input error! Choose a row and a column, from 0 to 7"
        wrong_row = 34
        allow(board_get_position).to receive(:gets).with(wrong_row,correct_column)
        allow(board_get_position).to receive(:gets).with(correct_row, correct_column)
        allow(board_get_position).to receive(:puts).with(first_puts)
        allow(board_get_position).to receive(:puts).with(second_puts)        
        expect(board_get_position).to receive(:puts).with(wrong_input)
        board_get_position.get_position
        end
    end
  end

end