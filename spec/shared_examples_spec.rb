require './lib/board.rb'
require './lib/pawn.rb'

 RSpec.shared_examples "move_piece_shared" do
    let(:board_shared_ex) { Board.new }
    let(:board) { board_shared_ex.board }
      
       context "when giving a valid goal for the piece" do
          it "moves piece to the goal" do
            board_shared_ex.move_piece(current_class, valid_goal)
            expect(board[valid_goal[0]][valid_goal[1]]).to be(current_class)  
        end

        it "resets to default the cell where the piece was" do
          pos_x = current_class.position[0]
          pos_y = current_class.position[1]          
          allow(board_shared_ex).to receive(:move_piece).with(current_class, valid_goal)
          expect(board[pos_x][pos_y]).to eq(' ')
        end

    end

       context "when giving an invalid goal once" do
         it "puts 'Input error!' once" do
          error_message = 'Invalid move!'
          allow(board_shared_ex).to receive(:move_piece).and_return(:puts, :put_piece)
          board_shared_ex.move_piece(current_class, invalid_goal)
          board_shared_ex.move_piece(current_class, valid_goal)  
         end
       end

        context "when given a cell occupied by a piece of another color" do
         let(:pawn) { Pawn.new([2,3], 'black') } 
  
          it "Moves it to the cell" do
            board[3][3] = current_class
            board[2][3] = pawn
            expect(board_shared_ex.move_piece(pawn, [3,3])).to be(pawn)
          end
      end
  end

RSpec.shared_examples "move_piece_occupied_path" do
  let(:board_second_shared) { Board.new }
  let(:board) { board_second_shared.board }
      
  context "when given a cell where the path is occupied" do
    let(:pawn) { Pawn.new([2,2], 'white') } 

      it "puts error" do
        board[1][2] = current_class 
        board[2][2] = pawn 
        expect(board_second_shared).to receive(:move_piece).and_return(:puts, :put_piece)
        board_second_shared.move_piece(current_class, invalid_goal)
      #  board_move_piece.move_piece(current_class, valid_goal)        
      end
    end  
end

=begin

       context "when given a cell where the path is occupied" do
      let(:knight) { Knight.new([3,3], 'white') }
      let(:rook) { Rook.new([2,2], 'white') } 
  
        it "puts error" do
          board[3][3] = knight 
          board[2][3] = rook 
          expect(board_move_piece).to receive(:move_piece).and_return(:puts, :put_piece)
          board_move_piece.move_piece(rook, [5,3])
          board_move_piece.move_piece(knight, [5,2])
        end
      end
=end