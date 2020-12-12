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
  
  # shared examples with parameters ?? 
  describe "#move_piece" do
   subject(:board_move_piece) { described_class.new }
   let(:board) { board_move_piece.instance_variable_get(:@board) }

    context "when giving a Knight" do
    let(:knight) { Knight.new([0,1], 'white')}

         it "moves it to goal if move is valid" do
             board_move_piece.move_piece(knight, [2,2])
             expect(board[2][2]).to be_instance_of(Knight)
         end

         it "puts 'Invalid move!' if move is invalid once" do 
            error_message = 'Invalid move!'
            allow(board_move_piece).to receive(:move_piece).and_return(:puts, :put_piece)
            board_move_piece.move_piece(knight, [4,4])
            board_move_piece.move_piece(knight, [2,2])         
        end

        it "resets to default the cell where the piece was" do
          allow(board_move_piece).to receive(:move_piece).with(knight, [2,2])
          expect(board[0][1]).to eq(' ')
        end
    end

    context "when given a cell occupied by a piece of the same color" do
    let(:knight) { Knight.new([3,3], 'white') }
    let(:pawn) { Pawn.new([2,3], 'white') } 

      it "puts 'Invalid move!' once " do
        board[3][3] = knight 
        board[2][3] = pawn
        expect(board_move_piece).to receive(:move_piece).and_return(:puts, :put_piece)
        board_move_piece.move_piece(pawn, [2,3])
        board_move_piece.move_piece(knight, [5,2])
      end
    end

    context "when given a cell occupied by a piece of another color" do
      let(:knight) { Knight.new([3,3], 'black') }
      let(:pawn) { Pawn.new([2,3], 'white') } 
  
        it "Moves it to the cell" do
          board[3][3] = knight 
          board[2][3] = pawn
          expect(board_move_piece).to receive(:move_piece).and_return(:puts, :put_piece)
          board_move_piece.move_piece(pawn, [2,3])
          board_move_piece.move_piece(knight, [5,2])
        end
      end
      
    context "when given a cell where the path is occupied" do
      let(:knight) { Knight.new([3,3], 'white') }
      let(:bishop) { Bishop.new([2,2], 'black') } 
  
        it "moves it to the cell" do
          board[3][3] = knight 
          board[2][2] = bishop 
          expect(board_move_piece).to receive(:move_piece).and_return(:puts, :put_piece)
          board_move_piece.move_piece(bishop, [6,6])
          board_move_piece.move_piece(knight, [5,2])
        end
      end

    #take a look at shared examples 
    context "when giving a pawn" do
    let(:pawn) { Pawn.new([1,1], 'white') } 
    let(:bishop) { Bishop.new([2,1], 'white')}

      it "moves it to goal if move is valid" do
          board_move_piece.move_piece(pawn, [2,1])
          expect(board[2][1]).to be_instance_of(Pawn)
      end

      it "puts 'Invalid move!' if move is invalid once" do 
         error_message = 'Invalid move!'
         allow(board_move_piece).to receive(:move_piece).and_return(:puts, :put_piece)
         board_move_piece.move_piece(pawn, [4,4])
         board_move_piece.move_piece(pawn, [2,1])         
      end
        
      it "puts 'Invalid move!' if goal cell is occupied by same color piece" do
         error_message = 'Invalid move!'
         board[2][1] = bishop
         allow(board_move_piece).to receive(:move_piece).and_return(:puts, :put_piece)
         board_move_piece.move_piece(pawn, [2,1])
         board_move_piece.move_piece(bishop, [4,3])         
      end

      it "resets to default the cell where the piece was" do
       allow(board_move_piece).to receive(:move_piece).with(pawn, [2,1])
       expect(board[0][1]).to eq(' ')
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